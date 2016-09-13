$(document).ready(function(){
  $('.toggle-state').click(function(e) {
    e.preventDefault();

    var ownerId, url;

    $button = $(this);

    ownerId = $button.data('owner-id');
    url     = $button.data('url');

    $.ajax({
      url: url,
      method: 'PUT',
      dataType: 'json',
      data: { todo_list_id: ownerId }
    }).done(function() {
      $button.closest('li').addClass('completed');
      $button.replaceWith('Done!')
    }).fail(function(jqXHR, textStatus, errorThrown) {
      var json = jqXHR.responseJSON;
      var flash = $('<div></div>').addClass('flash error').text(json.error_text);
      $('body').prepend(flash);
    });
  })
});
