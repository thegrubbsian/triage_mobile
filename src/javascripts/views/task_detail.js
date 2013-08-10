Views.TaskDetail = PageView.extend({

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
    this.template = Templates.task_detail;
  },

  preRender: function(data) {
    this.model = data.model;
  },

  render: function() {
    this.$el.html(this.template({ task: this.model }));
  }

});
