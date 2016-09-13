$(document).ready(function(){
  var stateToggle = new StateToggle;
  stateToggle.toggle();
});

// Recursive IIFE for polling incase server times out or something similar
(function poll(){
  setTimeout(function() {
    console.log('triggered poll');
    $.ajax({
      url: '/api/due_items.json',
      method: 'GET',
      dataType: 'json',
    }).done(function(res) {
      var todoItems = res.todo_items;

      if (todoItems.length > 0) {
        var stateToggle, modal;

        modal = new Modal;
        modal.open();
        stateToggle = new StateToggle;
        stateToggle.toggle();
      }

      poll();
    }).fail(function(jqXHR, textStatus, errorThrown) {
      poll();
    });
  }, 5000);
})();
