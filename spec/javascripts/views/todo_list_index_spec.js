describe("TodoListIndex", function () {
  describe("Todo Item Modal", function () {
    var modal = new Modal('#openModal');

    beforeEach(function () {
      loadFixtures("todo_list_index.html");
    });

    it("should add the css class when the modal is opened", function() {
      modal.open();
      expect($('#openModal')).toHaveClass('show');
    });

    it("should remove the css class when modal is closed", function() {
      modal.open();
      $('#openModal').addClass('show');
      modal.close();
      expect($('#openModal')).not.toHaveClass('show');
    });
  });
});
