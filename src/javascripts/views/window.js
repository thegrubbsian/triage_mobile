Views.Window = Backbone.View.extend({

  events: {
    "tap header #back-button": "goBack"
  },

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
  },

  goBack: function() {
    this.trigger("goBack");
  }

});
