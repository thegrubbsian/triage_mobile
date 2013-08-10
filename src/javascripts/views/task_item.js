Views.TaskItem = Backbone.View.extend({

  events: {
    "tap": "handleTap"
  },

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
    this.template = Templates.task_item;
  },

  render: function($list) {
    this.$el = $(this.template({ task: this.model })).appendTo($list);
    this.delegateEvents();
  },

  handleTap: function() {
    this.app.showView("taskDetail", { model: this.model });
  }

});
