$(document).ready(function(){

  $(document).on('click', '.add-item', function(){
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });

  $('button.complete').click(function(){
    var button = $(this)
    var list_id = $('ul').attr('id').replace('todo_list_','');
    var item_id = button.val().replace('due_','');
    var item = $('#todo_item_'+item_id);
    var item_button_selector = 'btn_' + item_id;
    var url = '/todo_lists/'+list_id+'/todo_items/'+item_id;

    $.ajax({
      url: url,
      type: "PATCH",
      data: {
        "todo_item": {done: true}
      },
      dataType: "json"
    }).done(function(data) {
      if (data['success']) {
        item.addClass('done');
        $(item_button_selector).replaceWith('Done!');
        hideModal();
      } else {
        $('.flash').text(data['error']);
      }
    }).fail(function(request, status, error) {
      $('.flash').text('Sorry, we could not mark your todo item as done.')
      console.log(error);
    });
  });

  $('button.dismiss').click(function(){
    hideModal();
  })

  startTimers();
});

var hideModal = function() {
  $('#myModal').modal('hide');
  $('body').removeClass('modal-open');
  $('.modal-backdrop').remove();
}

var startTimers = function() {
  var todoItems = $('p.due');

  var popupTimer = function(itemContent, itemId, count) {

    return function() {
      count -= 1;

      if (count <= 600) {
        clearInterval(count);
        $('.modal-body p').text(itemContent);
        $('.modal-footer button.complete').val(itemId);
        $("#myModal").modal();
      }
    }
  }

  var calculateTimeDiffInSeconds = function(dueTimeString) {
    var now = Date.now();
    var due = Date.parse(dueTimeString);
    var diff = due - Date.now();
    return diff/1000;
  }

  for (var i=0;i<todoItems.length;i++) {
    // Grab item attributes
    var item = todoItems.eq(i);
    var itemId = item.attr('id');
    var itemContent = item.attr('value');
    // Grab due time from text
    var dueTimeString = item.text();
    // Set counter to difference between now and due
    var count = calculateTimeDiffInSeconds(dueTimeString);

    // Find if item is done
    var closestLi = item.closest('li');
    var liClass = closestLi.attr('class');

    if (count > 0 && liClass != 'done') {
      console.log('start');
      setInterval(popupTimer(itemContent, itemId, count), 1000);
    }
  };
};
