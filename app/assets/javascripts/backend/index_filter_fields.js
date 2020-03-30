$(document).ready(function(){
  $('.mokio-filter-form select, .mokio-filter-form input').change(function(){
    $('.mokio-filter-form').submit();
  });
});
