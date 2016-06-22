$(document).ready(function(){

  $(document).on('click', '.add-item', function(){
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });
});