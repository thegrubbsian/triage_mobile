class Application extends Backbone.Base

  initialize: ->
    @initGlobalAjaxEvents()
    @currentUser = new Models.User()
    @tasks = new Collections.Tasks()
    @initFastClick()
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
        xhr.setRequestHeader("App-Platform", config.platform())
        xhr.setRequestHeader("Api-Version", config.apiVersion)
        xhr.setRequestHeader("App-Version", config.appVersion)
        xhr.setRequestHeader("User-Timezone-Offset", Helpers.currentTimezoneOffset())

  initFastClick: ->
    FastClick.attach(document.body)

  initViews: ->
    @viewHandler = new App.ViewHandler()

    @windowView = new Views.Window(el: "body", app: this)
    @proxyEvents @windowView

    @viewHandler.register "signIn", new Views.SignIn(el: "#sign-in", app: this)
    @viewHandler.register "signUp", new Views.SignUp(el: "#sign-up", app: this)
    @viewHandler.register "taskDetail", new Views.TaskDetail(el: "#task-detail", app: this)

    taskListView = new Views.TaskList(el: "#task-list", app: @, collection: @tasks)
    @viewHandler.register "taskList", taskListView
    @proxyEvents taskListView

    @settingsModal = new Views.SettingsModal(el: "#settings-modal")
    @proxyEvents @settingsModal

  bindEvents: ->
    @currentUser.on "userSignedIn", => @handleUserSignIn()
    @on "goBack", @handleGoBack
    @on "showSettingsModal", @handleShowSettingsModal
    @on "signOut", @handleSignOut
    @on "refreshTasks", @handleRefreshTasks

  handleUserSignIn: ->
    @setupAuthHeader()
    @fetchTasks()

  handleGoBack: =>
    @viewHandler.back()

  handleShowSettingsModal: =>
    @settingsModal.show()

  handleSignOut: =>
    @currentUser = null
    Store.clear()
    @showView "signIn"

  handleRefreshTasks: =>
    @fetchTasks()

  fetchTasks: ->
    @tasks.fetch success: => @handleTasksLoaded()

  authenticateUser: ->
    @showView "signIn"  unless @currentUser.attemptAutoSignIn()

  showView: (name, data) ->
    @viewHandler.show name, data
    @trigger "uiChanged"

  handleTasksLoaded: ->
    setTimeout (=> @showView "taskList", { state: "now" }), 100

#document.addEventListener("deviceready", (-> window.app = new Application()), false)
$ -> window.app = new Application()
