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
    var item_id = button.val();
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
      } else {
        $('.flash').text(data['error']);
      }
    }).fail(function(request, status, error) {
      $('.flash').text('Sorry, we could not mark your todo item as done.')
      console.log(error);
    });
  });
});