Views.Window = Backbone.View.extend({

  events: {
    "tap header #home-button": "showHome",
    "tap header #backb-button": "goBack",
    "tap header #new-gallery-button": "showNewGallery",
    "tap header #camera-button": "showNewPhoto"
  },

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
  },

  showNewGallery: function() {
    this.app.showView("newGallery");
  },

  showHome: function() {
    this.app.showView("home");
  },

  showNewPhoto: function() {
    this.app.showView("newPhoto");
  },

  goBack: function() {
    this.trigger("goBack");
  }

});
