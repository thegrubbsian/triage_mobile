// A stripped down base class which includes Backbone.Events and some
// basic constructor sugar.  This should be used for things that don't really
// fit into one of the other backbone types.

Backbone.Base = function() {
  this.initialize.apply(this, arguments);
};

Backbone.Base.extend = Backbone.Model.extend;

_.extend(Backbone.Base.prototype, Backbone.Events, {
  initialize: function() {}
});
