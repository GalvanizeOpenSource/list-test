$(document).ready(function(){

  $(document).on('click', '.add-item', function(){
    $('#openModal').addClass('show');

    var addItemPath = $(this).data('ajax-path');

    $('#openModal > div > button').on('click', function(){
      $.ajax({
	    url: addItemPath,
	    type: "POST",
	    data: {
	      todo_item: {
	        content: $('#openModal > div > #content').val(), 
	        due_date: $('#openModal > div > #due_date').val() 
	      }
	    },
	    success: function(data) {
	      $('#openModal').removeClass('show');
	      $('#main').html($(data).find('form'))
	    }
	  });
    })
  });

  $(document).on('click', '.close', function(){
    $('#openModal').removeClass('show');
  });
});