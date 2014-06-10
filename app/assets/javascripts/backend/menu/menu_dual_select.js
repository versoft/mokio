/* @author: Martyna Kolaczek, reviewed and accepted by Adam Stomski

  Function initializes dual select component with two select boxes. It allows moving items between the two boxes. 
  Second box allows drag & drop reordering of the elements.
*/
function dualSelectInit(html_id, filters){
  
  $.configureBoxes({
    useSorting: false,
    box1View: 'box1View' + html_id,
    box1Filter: 'box1Filter' + html_id,
    box1Storage: 'box1Storage' + html_id,
    box1Counter: 'box1Counter' + html_id,
    box2View: 'box2View' + html_id,
    box2Filter: 'box2Filter' + html_id,
    box2Storage: 'box2Storage' + html_id,
    box2Counter: 'box2Counter' + html_id,
    to1: 'to1' + html_id, 
    allTo1: 'allTo1' + html_id, 
    to2: 'to2' + html_id, 
    allTo2: 'allTo2' + html_id,
    useFilters: filters
  });

  $("#box2View" + html_id).data("size", $("#box2View"  + html_id + " option").size());
  
  $("#box2View"  + html_id + " option").livequery(reflect_options_to_li_add, reflect_options_to_li_remove);
  $('#fake-select' + html_id).sortable({
    update: function (event, ui) {reflect_order_li_to_options(event, ui)},
    live: true
  });

  $('#fake-select' + html_id).disableSelection();
  $('#fake-select' + html_id).liveFilter('#livefilter-input' + html_id, 'li', {});

  //allows selection of li elements as if they were <options>
  $('#fake-select' + html_id).on('click','li', function(event) {
    if (!$(this).hasClass('always_true')) {
      $(this).toggleClass('selected');
    }
  });

  $('#to1real' + html_id).on('click', select_li_to_options);
   $('#allTo1real' + html_id).on('click', remove_all_with_classes);
}  

//reflects changes of the <option> list (real-select) also on fake-select - on add

function reflect_options_to_li_add(){
    html_id = $(this).parent().attr('id').substring(8)
    // options were added to real select - they are also added to fake-select
    if ($("#box2View" + html_id +" option").size() > $("#box2View" + html_id).data("size")) {
      var newOptionsSize = $("#box2View" + html_id +" option").size() - $("#box2View" + html_id).data("size");
      var tempOpt;
      for (var i = newOptionsSize; i > 0; i--){
        tempOpt = $('#box2View' + html_id + ' option:nth-last-child(' + i + ')')
        $('#fake-select' + html_id).append('<li class="' + tempOpt.attr('class') + '" id="art_' + html_id + tempOpt.val() + '">' + tempOpt.text() + '</li>')
      }
    }
    $("#box2View" + html_id).data("size", $("#box2View" + html_id + " option").size());
}

//reflects changes of the <option> list (real-select) also on fake-select - on remove

function reflect_options_to_li_remove() {
  if ($(this).parent().attr('id')) {
    html_id = $(this).parent().attr('id').substring(8)
     // some options were removed from real select - they are also removed from fake-select
    if ($("#box2View" + html_id + " option").size() < $("#box2View"+ html_id).data("size")) {
      console.log('trutututu');
      if($('#box2View' + html_id + ' option').size() == 0) { //in this case we don't care about selected
        $('#fake-select' + html_id + ' li').not('.always_true').remove();
      }
      else {
        $('#fake-select' + html_id + ' .selected').not('.always_true').remove(); //we remove only selected elements
      }
    }
    $("#box2View" + html_id).data("size", $("#box2View" + html_id + " option").size());
  }
}

//reflects changes in the order of fake-select also in real select

function reflect_order_li_to_options(event, ui) {
  html_id = $(ui.item).parent().attr('id').substring(11);
  //what is now (after the change) before current element in fake-select list
  if (!(typeof ($(ui.item).prev().attr('id')) === 'undefined')) {
    var ident_prev = $(ui.item).prev().attr('id').substring(4 + html_id.length);
    var beforeReal = $('#box2View' + html_id +' option[value="' + ident_prev + '"]');
  }
  var ident_curr = $(ui.item).attr('id').substring(4 + html_id.length);
  //find corresponding option tags in real select 
  var currentReal = $('#box2View' + html_id +' option[value="' + ident_curr + '"]');
  //move current option to proper position in real select
  if (!(typeof beforeReal === 'undefined' )) {
    beforeReal.after(currentReal);
  }
  else {
    $('#box2View'+ html_id).prepend(currentReal);
  }
}

//select in real-select what is selected in fake-select and moves it to left box

function select_li_to_options() {
  html_id = $(this).attr('id').substring(7);
  var selected_values = $('#fake-select' + html_id +' .selected').not('.always_true').map(function() { return $(this).attr('id').substring(4 + html_id.length)}).get();
  $('#fake-select' + html_id +' .selected').not('.always_true').remove();
  $('#box2View' + html_id).val(selected_values);
  $('#to1' + html_id).click();
  copy_classes(selected_values, html_id);
  if ($('#fake-select' + html_id +' .always_true, .selected').length > 0) {
    $('#fake-select' + html_id +' .always_true').removeClass('selected');
  }
 }

//copies elements from left to right with classes when 'move all to left' button is clicked

function remove_all_with_classes() {
  html_id = $(this).attr('id').substring(10);
  var selected_values = $('#fake-select' + html_id +' li').not('.always_true').map(function() { return $(this).attr('id').substring(4 + html_id.length)}).get();
  $('#fake-select' + html_id +' li').not('.always_true').remove();
  $('#box2View' + html_id).val(selected_values);
  $('#to1' + html_id).click();
  copy_classes(selected_values, html_id);
}

//copies classes for elements from fale-list to right box

function copy_classes(selected_values, html_id) {
  $('#box1View' + html_id +' option').each(function(index) {
    if ($.inArray($(this).val(), selected_values) >= 0) {
      var classToCopy = $('#art' + html_id + '_' + $(this).val()).attr('class');
      $(this).addClass(classToCopy);
    }
  });
}

function remove_except_all_lang(html_id) {
  var toRemove = $('#fake-select' + html_id +' li').not('.always_true').not('.all_lang');
  var selected_values = toRemove.map(function() { return $(this).attr('id').substring(4 + html_id.length)}).get();
  toRemove.remove();
  $('#box2View' + html_id).val(selected_values);
  $('#box2View' + html_id + ' option:selected').remove();
}