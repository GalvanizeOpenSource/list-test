var TodoItem = function(selector) {
  this.selector = selector || '.submit-button';
  this.content = $('#content');

  this.submit = function() {
    var that = this;

    $(this.selector).click(function(e) {

      var url = that.content.data('url');
      var data = { todo_list_id: that.content.data('parentId'), content: that.content.val() };

      if (that.content.length > 0) {
        $.ajax({
          url: url,
          dataType: 'json',
          method: "POST",
          data: data
        }).done(function(res) {
          // Reset form field
          that.content.val('');
          that.content.next().replaceWith("<ul>" + res.message + "</ul>");

        }).fail(function(jqXHR) {
          var errors = jqXHR.responseJSON.errors;
          var errorHtml = errors.map(function(message, index) {
            return "<li>" + message + "</li>";
          });

          that.content.after("<ul>" + errorHtml.join('') + "</ul>");
        });
      }
    });
  }
}

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

  var todoItem = new TodoItem;
  todoItem.submit();
});
