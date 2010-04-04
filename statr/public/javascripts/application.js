// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(function($) {
  StatusUpdateBox = function() {
    this.textBox               = $('#post_status_update');
    this.charactersLeftCounter = $('#characters_left');
    this.maxCharacters         = 140;
  };

  $.extend(StatusUpdateBox.prototype, {
    init: function() {
      this.limitCharacters();
      this.textBox.keyup(function() {
        updateBox = new StatusUpdateBox();
        updateBox.limitCharacters();
      });
    },
    
    trimCharacters: function() {
      this.textBox.val(this.textBox.val().substring(0, this.maxCharacters));
    },
    
    showCurrentCharacters: function() {
      this.charactersLeftCounter.html(this.maxCharacters - this.countCharacters());
    },
    
    countCharacters: function() {
      return this.textBox.val().length;
    },
    
    limitCharacters: function() {
      if (this.countCharacters() > this.maxCharacters) {
        this.trimCharacters();
      } 
      this.showCurrentCharacters();
    }
  });
})(jQuery);

jQuery().ready(function() {
  updateBox = new StatusUpdateBox();
  updateBox.init();
});