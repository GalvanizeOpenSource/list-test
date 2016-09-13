$(document).ready(function(){
  var modal = new Modal('#openModal');

  $(document).on('click', '.add-item', function(){
    modal.open();
  });

  $(document).on('click', '.close', function(){
    modal.close();
  });
});
