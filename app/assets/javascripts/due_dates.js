$(document).ready(function(){
  $('li > .due_date').each(function(index, el) {
  	var dueDate = $(el).data('due-date');
  	if (dueDate !== null) {
  	  $(el).text('Due Date:  ' + formatDate(new Date(dueDate)));
  	}
  });
});