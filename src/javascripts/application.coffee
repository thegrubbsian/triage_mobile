class Application extends Backbone.Base

  initialize: ->
    @initGlobalAjaxEvents()
    @currentUser = new Models.User()
    @tasks = new Collections.Tasks()
    @initViews()
    @bindEvents()
    @authenticateUser()

  initGlobalAjaxEvents: ->
    $(document).ajaxError (e, xhr, data) =>
      console.log "ajaxError: " + data.url + ", " + xhr.responseText
      if xhr.status is 403
        console.log "invalid auth_key, signing out"
        @showView "signIn"
        Store.clear()

  setupAuthHeader: ->
    authKey = @currentUser.get("auth_key")
    $.ajaxSetup
      beforeSend: (xhr) ->
        xhr.setRequestHeader("User-Auth-Key", authKey)

  bindEvents: ->
    @currentUser.on "userSignedIn", => @handleUserSignIn()
    @on "goBack", @handleBackButton

  handleUserSignIn: ->
    @setupAuthHeader()
    @tasks.fetch success: => @handleTasksLoaded()

  handleBackButton: ->
    @viewHandler.back()

  initViews: ->
    @viewHandler = new App.ViewHandler()

    @windowView = new Views.Window(el: "body", app: this)
    @proxyEvents @windowView

    @viewHandler.register "signIn", new Views.SignIn(el: "#sign-in", app: this)
    @viewHandler.register "signUp", new Views.SignUp(el: "#sign-up", app: this)
    @viewHandler.register "taskDetail", new Views.TaskDetail(el: "#task-detail", app: this)

    _(["now", "later", "done", "archived"]).each (state) =>
      listView = new Views.TaskList(
        el: "#" + state + "-list", app: @, collection: @tasks, state: state
      )
      @viewHandler.register state + "List", listView

  authenticateUser: ->
    @showView "signIn"  unless @currentUser.attemptAutoSignIn()

  showView: (name, data) ->
    @viewHandler.show name, data

  handleTasksLoaded: ->
    @showView "nowList"

$ -> window.app = new Application()
