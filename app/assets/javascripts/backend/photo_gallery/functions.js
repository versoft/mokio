//
// Modal to remember
//
var Modal = {
  edited: "",

  show: function() {
    this.edited.modal();
  },
  close: function() {
    $(".photo-options-fields").fadeOut(500);
    $(".btn-options").removeClass('show');
    this.edited.modal('hide');
  },
  id: function() {
    return this.edited.attr('id').replace(/[a-zA-Z_]/g, ""); // get photo id
  }
}

//
// Main all load scripts
//
function gallery_load() {
  prettyphoto();
  gallery_lazy_load();

  $(".fancybox").fancybox();

  submitmodal();
  edit_image_button();

  //
  // Clickable modal inputs and textareas
  //
  $('.modal input, .modal textarea').bind('click mouseup mousedown keypress keydown keyup', function (e) {
      e.stopPropagation();
  });

  sortablephotos();
  editForm();
  photo_options_fields();
}

//--------------- Prettyphoto ------------------//

function prettyphoto(){
  $("a[rel^='prettyPhoto']").prettyPhoto({
    default_width: 800,
    default_height: 600,
    theme: 'facebook',
    social_tools: false,
    show_title: false,
    changepicturecallback: function() {
      $(".pp_play").remove();
    }
  });
}

//--------------- Gallery & lazzy load & jpaginate ------------------//

function gallery_lazy_load() {
  //hide the action buttons
  $('.actionBtn, .dragable').hide();
  //show action buttons on hover image
  $('.galleryView>li').hover(
    function () {
       $(this).find('.actionBtn').stop(true, true).show(300);
       $(this).find('.dragable,.handler').stop(true, true).show(300);
    },
    function () {
        $(this).find('.actionBtn').stop(true, true).hide(300);
        $(this).find('.dragable,.handler').stop(true, true).hide(300);
    }
  );
  //
  // remove the gallery item after press delete
  //
  $('.actionBtn>.delete').click(function(){
    $(this).closest('li').remove();
    prettyphoto();
  });

  /* initiate lazyload defining a custom event to trigger image loading  */
  $("ul#itemContainer li img").lazyload({
      event : "turnPage",
      effect : "fadeIn"
  });
  /* initiate plugin */
  $("div.holder").jPages({
      containerID : "itemContainer",
      animation   : "fadeInUp",
      perPage     : 16,
      scrollBrowse   : true, //use scroll to change pages
      keyBrowse   : true,
      callback    : function( pages ,items ){
          /* lazy load current images */
          items.showing.find("img").trigger("turnPage");
          /* lazy load next page images */
          items.oncoming.find("img").trigger("turnPage");
      }
  });
};

//
// submit modal button, works with ajax
//
function submitmodal(){
  $('.edit_modal_submit').click(function() {
    $id = "#" + $(this).parents('.modal').attr('id');

    setTimeout(function() {
      $($id).modal('hide');
    }, 250);
  });
}

function addEditLayout(id) {
  $(document.body).append("<div class=\"modal-backdrop fade in\"></div>")
                  .append("<div class=\"editwrapper\"><div id=\"" + id + "\" class=\"photo_holder\"></div></div>");

  $(".photo_holder").hide();
}

function edit_image_button() {
  $(".edit_view_img_container .btn-primary").off();
  $(".edit_view_img_container .btn-primary").click(function(event) {
    /* Act on the event */
    event.preventDefault();

    image = $(this).parents(".edit_view_img_container").find('img');

    if ( image.hasClass('thumb') ) {
      PhotoEditForm.photo_type = "thumb";
    }
    else {
      PhotoEditForm.photo_type = "photo";
    }

    Modal.edited = $(this).parents('.modal'); // remember edited modal
    Modal.close();

    // timeout to load javascript asynchronously
    setTimeout(function() {                                                                    //
      $id = Modal.id();                                                                        // Main Photo
      addEditLayout($id);                                                                      //

      $.get("/" + Mokio.engine_root() + "/photos/" + $id + "/get_" + PhotoEditForm.photo_type, function(data) { });
    }, 500);  
  }); 
}

//
// make photos sortable and draggable 
//
function sortablephotos(){
  $('.sortable').sortable({
    handle: '.dragable .handler',
    placeholder: "ui-state-highlight",

    //
    // problems with position dropped photos
    //
    helper: function(e, ui) {
      $(ui).width($(ui).width());
      $(ui).height($(ui).height());

      ui.children().each(function() {
        $(this).width($(this).width());
      });
      return ui;
    },
    stop: function(event, ui) {
      var $idsInOrder = [];

      $('.sortable li.sortableli').each(function(n){
        $idsInOrder.push($(this).attr('id')); // get photos id's in order asc
      });

      $.post( '/' + Mokio.engine_root() + '/data_files/sort/', { ids_order: $idsInOrder } ); // ajax to sort photos
      prettyphoto();
    }
  }).disableSelection();
}

//
// destroy instances of ckeditor
//
function ckeditorDestroy() {
  if ($('#pic_gallery_intro').length > 0) {
    CKEDITOR.instances.pic_gallery_intro.updateElement();
    CKEDITOR.instances.pic_gallery_intro.destroy();
  }
  if ($('#pic_gallery_content').length > 0) {
    CKEDITOR.instances.pic_gallery_content.updateElement();
    CKEDITOR.instances.pic_gallery_content.destroy();  
  }
  if ($('#slider_intro').length > 0) {
    CKEDITOR.instances.slider_intro.updateElement();
    CKEDITOR.instances.slider_intro.destroy();
  }
  if ($('#slider_content').length > 0) {
    CKEDITOR.instances.slider_content.updateElement();
    CKEDITOR.instances.slider_content.destroy();  
  }
}

//
// replace instances of ckeditor
//
function ckeditorReplace() {
  if ($('#pic_gallery_intro').length > 0) {
    CKEDITOR.replace( 'pic_gallery_intro', {height: "150px", toolbar: "Mini"});
  }
  if ($('#pic_gallery_content').length > 0){
    CKEDITOR.replace( 'pic_gallery_content', {height: "300px", toolbar: "Medium"});
  }
  if ($('#slider_intro').length > 0){
    CKEDITOR.replace( 'slider_intro', {height: "150px", toolbar: "Mini"});
  }
  if ($('#slider_content').length > 0){
    CKEDITOR.replace( 'slider_content', {height: "300px", toolbar: "Medium"});
  }
}

//
// hide/show gallery form
//
function editForm() {
  $content = $('.editcontent');
  $content.hide();

  $('.editcontentbtn').addClass('show');
  $('.editcontentbtn').click(function(){
    $this = $(this);

    //
    // ckeditor does not response after animation or hide/show(on Chrome)
    // recreate it on show and destroy on hide to prevent bugs
    //
    if ( $this.hasClass('show') ){
      // console.log(typeof CKEDITOR.instances.pic_gallery_intro);
      if ( typeof CKEDITOR.instances.pic_gallery_intro == 'undefined' && typeof CKEDITOR.instances.slider_intro == 'undefined' ) {
        ckeditorReplace();
      }
      else {
        ckeditorDestroy();
        ckeditorReplace();
      }
      // show content
      $content.removeClass('hidden');
      $content.slideDown(1000);
      $this.removeClass('show');

      $("html, body").animate({
        scrollTop: ( $(".editcontentbtn").first().offset().top )
      }, 1000);

    }
    else {
      // hide content
      $content.slideUp(1000, function(){
        $content.addClass('hidden');
        $this.addClass('show');
        ckeditorDestroy();
      });
      $('pic_gallery_comment_type')
    }
  });
}

function updateAjaxPhoto() {
  $("#photo_edited").attr("src", $("#photo_edited").attr("src") + "?" + new Date().getTime());
}

function reloadScriptsForPhoto(id) {
  $('.galleryView>li').off('mouseenter mouseleave');

  gallery_lazy_load();
  prettyphoto();
  submitmodal();
  sortablephotos();

  $(".btn-options").off();
  $(".photo-options-fields li.photo_thumb").off();
  $(".photo-options-fields li.photo_main").off();
  photo_options_fields();

  $("li#" + id).find("img").attr('src', $("li#" + id).find("img").attr('src') + "?" + new Date().getTime());
  $("#modaledit_" + id).find('img').attr('src', $("#modaledit_" + id).find('img').attr('src') + "?" + new Date().getTime());

  //
  // Clickable modal inputs and textareas
  //
  $('.modal input, .modal textarea').bind('click mouseup mousedown keypress keydown keyup', function (e) {
      e.stopPropagation();
  });

  edit_image_button();

  $(".fancybox").fancybox();
}

function showLoader() {
  $(".photo_holder").append('<div id="loader"></div>');
}

function reloadScripts() {
  Modal.edited = $("#modaledit_" + Modal.id());

  reloadScriptsForPhoto($(".photo_holder").attr('id'));

  $("#edit_photo_" + Modal.id() + " .activebutton input[type=checkbox]" ).attr('class', 'activebtn')
                                   .attr('data-on-label', '<i class="icomoon-icon-checkmark white"></i>')
                                   .attr('data-off-label', '<i class="icomoon-icon-cancel-3 white"></i>');

  $("#edit_photo_" + Modal.id() + " .activebtn" ).bootstrapSwitch()
                 .bootstrapSwitch('setOnClass', 'success')
                 .bootstrapSwitch('setOffClass', 'danger')
                 .bootstrapSwitch('setSizeClass', 'switch-small');  
}

function photo_options_fields() {
  $option_field = $(".photo-options-fields");
  $option_field.hide();

  $(".btn-options").click(function(event) {
    if ( $(this).hasClass('show') ) {
      // hide 
      $option_field.slideUp(500);
      $(this).removeClass('show');
    }
    else {
      // show
      $option_field.slideDown(500);
      $(this).addClass('show');
    }
  });

  $(".photo-options-fields li.photo_thumb").click(function(event) {
    /* Act on the event */
    Modal.edited = $(this).parents('.modal'); // remember edited modal
    Modal.close();

    PhotoEditForm.photo_type = "thumb";

    // timeout to load javascript asynchronously
    setTimeout(function() {                                                                    //
      $id = Modal.id();                                                                        // Photo thumb
      addEditLayout($id);                                                                      //

      $.get('/' + Mokio.engine_root() +'/photos/' + $id + '/get_thumb', function(data) { });
    }, 500);
  });

  //
  // For better appearance
  //
  $background = $(".photo-options-fields li").css('backgroundColor');

  $(".photo-options-fields li").hover(function() {
    /* Stuff to do when the mouse enters the element */  
    $(this).stop().animate({backgroundColor: "#E6E6E6"}, 500);

  }, function() {
    /* Stuff to do when the mouse leaves the element */
    $(this).stop().animate({backgroundColor: $background}, 500);
  });
}

function activeButtonForPhoto(id) {
  $("#edit_photo_" + id + " .activebutton input[type=checkbox]" ).attr('class', 'activebtn')
                                   .attr('data-on-label', '<i class="icomoon-icon-checkmark white"></i>')
                                   .attr('data-off-label', '<i class="icomoon-icon-cancel-3 white"></i>');

  $("#edit_photo_" + id + " .activebtn" ).bootstrapSwitch()
                 .bootstrapSwitch('setOnClass', 'success')
                 .bootstrapSwitch('setOffClass', 'danger')
                 .bootstrapSwitch('setSizeClass', 'switch-small');
}

function init_link_upload_textarea() {
  $("#photo_remote_data_file_url").attr('style', 'height:200px;');

  $(".upload_external_links_btn").click(function(event) {
    /* Act on the event */
    $("#modal_external_link .modal-header #myModalLabel2").append('<div class="loader"></div>')
  });

  $('#photo_remote_data_file_url').bind('change keyup', function(event) {
    //Option 1: Limit to # of rows in textarea
    rows = $(this).attr('rows');
    //Optiion 2: Limit to arbitrary # of rows
    rows = 10;

    var value = '';
    var splitval = $(this).val().split("\n");

    for (var a=0; a<rows && typeof splitval[a] != 'undefined'; a++) {
      if ( a > 0 ) value += "\n";
      value += splitval[a];
    }
    $(this).val(value);
  });

  var placeholder = 'http:://link\nhttp:://link\nhttp:://link\nhttp:://link\n';

  $('#photo_remote_data_file_url').prop('value', placeholder).css('opacity', '0.7');

  $('#photo_remote_data_file_url').focus(function() {
      if ( $(this).val() == placeholder ) {
        // reset the value only if it equals the initial one    
        $(this).prop('value', '').css('opacity', '1');
      }
  });

  $('#photo_remote_data_file_url').blur(function() {
      if ( $(this).val() == '' ) {
        $(this).prop('value', placeholder).css('opacity', '0.7');
      }    
  });
  
  // remove the focus, if it is on by default
  $('#photo_remote_data_file_url').blur();
}