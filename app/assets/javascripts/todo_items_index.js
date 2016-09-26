$(document).ready(function(){

  $(document).on('click', '.delete-item', function() {
    updateDeleteLink($(this).data('link'));
    $('#delete-confirm').addClass('show');
  });

  $(document).on('click', '.close', function() {
    hideModal();
  });

  $(document).on('click', '.cancel', function() {
    hideModal();
  });

  function hideModal() {
    $('#delete-confirm').removeClass('show');
  };

  function updateDeleteLink(link) {
    $('#delete-item-link').attr('href', link);
  };
});
