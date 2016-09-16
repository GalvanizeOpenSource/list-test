var StateToggle = function(selector) {
  this.selector = selector || '.toggle-state';

  // TODO: Fix this name, it's terrible...
  this.toggle = function() {
    var that = this;
    $(this.selector).click(function(e) {
      e.preventDefault();

      var $button = $(this);

      var isModal = $button.data('modal');
      var ownerId = $button.data('owner-id');
      var url     = $button.data('url');

      $.ajax({
        url: url,
        method: 'PUT',
        dataType: 'json',
        data: { todo_list_id: ownerId }
      }).done(function () {
        if (isModal != undefined) {
          that.completeModalState($button);
        } else {
          that.completeListState($button)
        }
      }).fail(function(jqXHR) {
        that.handleError(jqXHR)
      });
    });
  }

  this.handleError = function(jqXHR) {
    var json = jqXHR.responseJSON;
    var flash = $('<div></div>').addClass('flash error').text(json.error_text);
    $('body').prepend(flash);
  }

  this.completeModalState = function(button) {
    $(button).closest('li').addClass('hide');
    $(button).replaceWith('');
  }

  this.completeListState = function(button) {
    $(button).closest('li').addClass('completed');
    $(button).replaceWith('Done!');
  }
}
