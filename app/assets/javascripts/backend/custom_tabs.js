// Tabs for form tabbed content

$('.custom_tab_link').on('click', function() {
  $('.single_tab').removeClass('active');

  var activeTab = $(this).find('a').attr('href');
  $(activeTab).addClass('active');

  if ($('#gallery_tab').hasClass('active')) {
    $('#form_buttons').css('display', 'none');
  } else {
    $('#form_buttons').css('display', 'block');
  }
});