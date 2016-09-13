$(document).ready(function(){
  var modal = new Modal('#openModal');

  $('.add-item').click(function(e) {
    e.preventDefault();

    var dataListId = $(this).data('list-id');
    $('#content').data('parentId', dataListId);

    modal.open();
  });

  $('.close').click(function(e) {
    e.preventDefault();

    modal.close();
  });

  $('.submit-button').click(function(e) {
    var $content = $('#content');

    var url = $content.data('url');
    var data = { todo_list_id: $content.data('parentId'), content: $content.val() };

    if ($content.length > 0) {
      $.ajax({
        url: url,
        dataType: 'json',
        method: "POST",
        data: data
      }).done(function(res) {
        // Reset form field
        $content.val('');
        console.log(res);
      }).fail(function(jqXHR) {
        console.log(jqXHR);
        var errors = jqXHR.responseJSON.errors;
        var content = errors.map(function(message, index) {
          $('<li>').val(message);
        });



        $('<ul>').prepend(content);
      });
    }
  });
});
