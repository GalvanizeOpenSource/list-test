$(document).ready(function(){

  $(document).on('click', '.add-item', function(){
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });

  $('button').click(function(){
    var button = $(this);
    var list_id = $('ul').attr('id').replace('todo_list_','');
    var item = button.closest('li');
    var item_id = item.attr('id').replace('todo_item_','');
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
        button.replaceWith('Done!');
      } else {
        $('.flash').text(data['error']);
      }
    }).fail(function(request, status, error) {
      $('.flash').text('Sorry, we could not mark your todo item as done.')
      console.log(error);
    });
  });
});