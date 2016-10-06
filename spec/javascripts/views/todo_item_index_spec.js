describe("TodoItemIndex", function () {
  describe("Todo Item Delete Modal", function () {
    beforeEach(function () {
      loadFixtures("todo_item_index.html");
    });

    it("should open the modal if Delete is clicked", function() {
      $('.delete-item').trigger('click');
      expect($('#openModal')).toHaveClass('show');
    });

      it("should close the modal if OK is clicked", function() {
          $('#openModal').addClass('show');
          $('.confirm-delete').trigger('click');
          expect($('#openModal')).not.toHaveClass('show');
      });

      it("should call to delete the item if OK is clicked", function() {
          spyOn($, "ajax");
          $('.delete-item').trigger('click');
          $('.confirm-delete').trigger('click');
          expect($.ajax.calls.mostRecent().args[0]["url"]).toEqual("/todo_lists/1/todo_items/1");
          expect($.ajax.calls.mostRecent().args[0]["type"]).toEqual("DELETE");
      });

    it("should close the modal if X is clicked", function() {
      $('#openModal').addClass('show');
      $('.close').trigger('click');
      expect($('#openModal')).not.toHaveClass('show');
    });
  });
});
