# Galvanize Coding Assignment


## If you are applying to the Senior Developer position:
### Implement the following feature:
Add the ability for a user to specify a due date and time for a todo item.

The user should be able to mark the item as done from a button in the todo item row on the todo_items#index page.

Upon clicking on the button, the button should be replaced by the text "Done!" and the background color of the todo item row should be changed to #E0EEE0.  Also, 10 minutes prior to a task being due, a modal should open announcing with title of "Todo Item Due" and a body of "Due in 10 minutes:" with the todo item description shown on the next line.  The modal should have two buttons, Done and Dismiss.  Done should mark the task as done, and Dismiss should close the modal with no change to the todo item.

Any errors should display a flash message at the top of the todo_items#index page which says "Sorry, we could not mark your todo item as done".

In the todo item index, order todo items by due date descending from oldest date.  Any todo items without a due date should be listed after those with a due date in alphabetical decending order.

Remove deprecation errors

Make failing tests pass

Write all appropriate tests for the new delete functionality


## If you are applying to the Junior Developer position:
### Implement the following feature:
Add the ability to delete a todo item from the todo_item#index page.

Add a link in the todo item row that when the user clicks on it, it will open a confirmation modal.

If the user confirms the decision to delete the specified todo item the todo item should be deleted and the user should be redirected to the root path.  They should see a flash message saying "Your todo item was successfully removed".  If the last todo item is deleted from the todo list, delete the todo list as well.  The flash message in that case should say "The last todo item was successfully removed and your todo list was deleted."

If there is an error, redirect them to the todo_item#index page and display a flash of "Sorry, there was a problem deleting the todo item".

Remove deprecation errors

Make failing tests pass

Write all appropriate tests for the new delete functionality
