$(document).ready(function(){
  $('li > .clock').each(function(i, el) {
  	  var dueDate = $(el).data('due-date');

	  function initializeClock(endtime) {
	    if(dueDate === null) {
	      return;
	    }

	    function updateClock() {
		  var t = new Date();

		  if (t >= endtime && !$(el).hasClass('due-date-addressed')) {
		  	$(el).addClass('due-date-addressed');
		  	var modalId = $(el).data('id');
		  	$('[data-modal-id=' + modalId + ']').addClass('show');
		  	clearInterval(timeinterval);
		  	
		  	var updateItemPath = $('[data-modal-id=' + modalId + ']').data('ajax-path')

		  	$(document.body).on('click', '[data-modal-id=' + modalId + '] > div > #done', function(event) {
		  	  $.ajax({
			    url: updateItemPath,
			    type: "PUT",
			    data: {
			      todo_item: {
			        done: true
			      }
			    },
			    success: function(data) {
			      $('[data-modal-id=' + modalId + ']').removeClass('show');
			    }
			  });
		  	});

		  	$(document.body).on('click', '[data-modal-id=' + modalId + '] > div > #dismiss', function(event) {
			  $('[data-modal-id=' + modalId + ']').removeClass('show');
			});
		  }
		}

		updateClock();
		var timeinterval = setInterval(updateClock, 1000);    
	  };
	  
	  if (dueDate) {
		var currentTime = Date.parse(new Date());
		var deadline = convertToLocalTime(new Date(dueDate)).getTime() - 60*10*1000;

		initializeClock(deadline);
	  }
	});
});