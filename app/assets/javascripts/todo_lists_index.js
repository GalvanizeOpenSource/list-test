$(document).ready(function(){

  $(document).on('click', '.add-item', function(){
    $('#openModal').addClass('show');
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });

  $('button').click(function(){
    $(this).closest('li').css('background-color', '#E0EEE0');
    $(this).replaceWith('Done!');
  });
});