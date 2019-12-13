function backend_dynamic_fields(assoc) {
  $(assoc).on('click', '.dynamic_fields_remove_row', function(event) {
    var message = $(this).data('message');

    var confirmation = confirm(message);
    if (confirmation) {
      $(this).closest('td').find('input').val(true);
      $(this).closest('.dynamic_fields_row').hide();
    }
    return event.preventDefault();
  });

  $(assoc).on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(assoc).find('.dynamic_fields_container_fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
}