var Modal = function(selector) {
  this.selector = selector || '#openModal';

  this.toggle = function() {
    $(this.selector).toggleClass('show');
  };

  this.open = function() {
    $(this.selector).addClass('show');
  }

  this.close = function() {
    $(this.selector).removeClass('show');
  }
}
