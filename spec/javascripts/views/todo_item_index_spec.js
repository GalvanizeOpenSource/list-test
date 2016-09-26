describe("TodoItemIndex", function() {
  describe("Delete Confirmation Modal", function() {
    beforeEach(function() {
      loadFixtures("todo_item_index.html");
    });

    it("should open the modal if Delete is clicked", function() {
      $('.delete-item').trigger('click');
      expect($('#delete-confirm')).toHaveClass('show');
    });

    it("should update the href of the delete link in the modal", function() {
      $('.delete-item').trigger('click');
      expect($('#delete-item-link').attr('href')).toMatch('/path/to/delete');
    });

    it("should close the modal if X is clicked", function() {
      $('#delete-confirm').addClass('show');
      $('.close').trigger('click');
      expect($('#openModal')).not.toHaveClass('show');
    });

    it("should close the modal if cancel is clicked", function() {
      $('#delete-confirm').addClass('show');
      $('.cancel').trigger('click');
      expect($('#openModal')).not.toHaveClass('show');
    });
  });
});
