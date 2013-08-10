var PageView = Backbone.View.extend({

  show: function(data, isGoingBack) {
    if (typeof isGoingBack === "undefined") { isGoingBack = false; }
    if (this.preRender) {
      var autoRender = this.preRender(data, isGoingBack);
      if (autoRender !== false) {
        if (this.render) {
          this.render();
          this.fadeIn();
        }
      }
    } else {
      if (this.render) {
        this.render();
        this.fadeIn();
      }
    }
  },

  fadeIn: function() {
    $(".page.in").removeClass("in");
    this.$el.removeClass("out").addClass("in");
  },

  release: function() {
    this.fadeOut();
    setTimeout(this.releaseComplete, 300);
  },

  releaseComplete: function() {
    this.$el.empty();
  },

  fadeOut: function() {
    $(".page.out").removeClass("out");
    this.$el.addClass("out");
  }

});
