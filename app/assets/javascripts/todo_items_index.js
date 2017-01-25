var ONE_MINUTE = 60 * 1000,
    TEN_MINUTES = ONE_MINUTE * 10;


function checkForReminders() {
  $("ul.todo_items li").each(function() {
    var date = new Date(),
        dueTime = $(this).data("due-time") * 1000;

    // We only care about having precision at the minute level,
    // so we'll zero out the seconds/milliseconds for the current time
    date.setSeconds(0);
    date.setMilliseconds(0);

    var currentTime = date.getTime();

    if(dueTime - currentTime == TEN_MINUTES) {
      var list_id = $(this).data("list-id"),
          item_id = $(this).data("item-id"),
          content = $(this).data("content"),
          done_url = "/todo_lists/"+list_id+"/todo_items/"+item_id+"/mark_done";

      $("#reminderContent").text(content);
      $("#reminderDone").attr('href', done_url);
      $("#reminderModal").addClass("show");
    }
  });
}

$(document).ready(function() {
  setInterval(checkForReminders, ONE_MINUTE);

  $("#reminderDismiss").on("click", function() {
    $("#reminderModal").removeClass("show");
  });
});
