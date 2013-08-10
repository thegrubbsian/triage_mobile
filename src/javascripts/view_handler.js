var ViewHandler = Backbone.Base.extend({

  views: {},
  history: [],

  current: function() {
    if (this.history.length == 0) { return null; }
    return this.history[this.history.length - 1];
  },

  register: function(name, view) {
    this.views[name] = view;
    this.proxyEvents(view);
  },

  get: function(name) {
    return this.views[name];
  },

  back: function() {
    if (this.history.length <= 1) { return; }
    if (this.current()) {
      var prevView = this.history.pop();
      this.get(prevView.name).release();
      this.get(this.current().name).show(this.current().data, true);
    }
    this.trigger("changingView", this.current().name);
  },

  show: function(name, data) {
    if (typeof data === "undefined") { data = {}; }
    if (this.current() && this.current().name === name) { return; }
    if (this.current()) {
      this.get(this.current().name).release();
    }
    this.history.push({ name: name, data: data });
    this.get(name).show(data, false);
    this.trigger("changingView", this.current().name);
  }

});
