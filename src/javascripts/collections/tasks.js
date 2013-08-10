Collections.Tasks = Backbone.Collection.extend({

  model: Models.Task,
  url: config.url("/tasks"),

  initialize: function() {
  },

  eachInState: function(state, func) {
    var models = this.where({ state: state });
    _(models).each(func);
  }

});
