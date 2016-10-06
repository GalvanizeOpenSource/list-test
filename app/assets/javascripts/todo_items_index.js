$(document).ready(function(){

  $(document).on('click', '.delete-item', function(e){
    e.preventDefault();
    $('.confirm-delete').data('itemId', $(e.target).data('itemId'));
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.confirm-delete', function() {
    $.ajax({
      url: '/todo_lists/' + $('.confirm-delete').data('listId') + '/todo_items/' + $('.confirm-delete').data('itemId'),
      type: 'DELETE'
    });
    $('#openModal').removeClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });
});