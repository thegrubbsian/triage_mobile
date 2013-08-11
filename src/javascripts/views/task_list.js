Views.TaskList = PageView.extend({

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
    this.state = this.options.state;
    this.template = Templates.task_list;
  },

  render: function() {
    this.$el.html(this.template({ state: this.state }));
    this.$list = this.$el.find("ul.list");
    this.collection.eachInState(this.state, this.renderItem);
    this.initSorting();
  },

  renderItem: function(task) {
    var itemView = new Views.TaskItem({ model: task, app: this.app });
    itemView.render(this.$list);
  },

  initSorting: function() {
    this.$list.find("li").sortable({ axis: "x", handle: "span.order" });
  }

});
