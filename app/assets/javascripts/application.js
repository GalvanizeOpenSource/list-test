// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require turbolinks
//= require_tree .

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

        modal = new Modal('#dueModal');
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

