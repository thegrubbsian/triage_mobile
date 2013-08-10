var App = Backbone.Base.extend({

  initialize: function() {
    _.bindSelf(this);
    this.initGlobalAjaxEvents();
    this.currentUser = new Models.User();
    this.tasks = new Collections.Tasks();
    this.initViews();
    this.bindEvents();
    this.authenticateUser();
  },

  initGlobalAjaxEvents: function() {
    var _self = this;
    $(document).ajaxError(function(e, xhr, data) {
      console.log("ajaxError: " + data.url + ", " + xhr.responseText);
      if (xhr.status === 403) {
        console.log("invalid auth_key, signing out");
        _self.showView("signIn");
        Store.clear();
      }
    });
  },

  setupAuthHeader: function() {
    var authKey = this.currentUser.get("auth_key");
    $.ajaxSetup({ data: { auth_key: authKey } });
  },

  bindEvents: function() {
    this.currentUser.on("userSignedIn", this.handleUserSignIn);
    this.on("goBack", this.handleBackButton);
  },

  handleUserSignIn: function() {
    this.setupAuthHeader();
    this.tasks.fetch({ success: this.handleTasksLoaded });
  },

  handleBackButton: function() {
    this.viewHandler.back();
  },

  initViews: function() {
    var _self = this;

    this.viewHandler = new ViewHandler();

    this.windowView = new Views.Window({ el: "body", app: this });
    this.proxyEvents(this.windowView);

    var signInView = new Views.SignIn({ el: "#sign-in", app: this });
    this.viewHandler.register("signIn", signInView);

    var signUpView = new Views.SignUp({ el: "#sign-up", app: this });
    this.viewHandler.register("signUp", signUpView);

    _(["now", "later", "done", "archived"]).each(function(state) {
      var listView = new Views.TaskList({
        el: "#" + state + "-list", app: _self, collection: _self.tasks, state: state
      });
      _self.viewHandler.register(state + "List", listView);
    });

    var taskDetailView = new Views.TaskDetail({ el: "#task-detail", app: this });
    this.viewHandler.register("taskDetail", taskDetailView);
  },

  authenticateUser: function() {
    if (!this.currentUser.attemptAutoSignIn()) {
      this.showView("signIn");
    }
  },

  showView: function(name, data) {
    this.viewHandler.show(name, data);
  },

  handleTasksLoaded: function() {
    this.showView("nowList");
  }

});

$(function() { window.app = new App(); });
