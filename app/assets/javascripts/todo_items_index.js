$(document).ready(function(){

  $(document).on('click', '.delete-item', function(){
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.confirm-delete', function() {
    $('#openModal').removeClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });
});