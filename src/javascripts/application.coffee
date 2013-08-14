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

  initFastClick: ->
    FastClick.attach(document.body)

  initViews: ->
    @viewHandler = new App.ViewHandler()

    @windowView = new Views.Window(el: "body", app: this)
    @proxyEvents @windowView

    @viewHandler.register "signIn", new Views.SignIn(el: "#sign-in", app: this)
    @viewHandler.register "signUp", new Views.SignUp(el: "#sign-up", app: this)
    @viewHandler.register "taskDetail", new Views.TaskDetail(el: "#task-detail", app: this)
    @viewHandler.register "taskList",
      new Views.TaskList(el: "#task-list", app: @, collection: @tasks)

    @settingsModal = new Views.SettingsModal(el: "#settings-modal")
    @proxyEvents @settingsModal

  bindEvents: ->
    @currentUser.on "userSignedIn", => @handleUserSignIn()
    @on "goBack", @handleGoBack
    @on "showSettingsModal", @handleShowSettingsModal
    @on "signOut", @handleSignOut

  handleUserSignIn: ->
    @setupAuthHeader()
    @tasks.fetch success: => @handleTasksLoaded()

  handleGoBack: =>
    @viewHandler.back()

  handleShowSettingsModal: =>
    @settingsModal.show()

  handleSignOut: =>
    @currentUser = null
    Store.clear()
    @showView "signIn"

  authenticateUser: ->
    @showView "signIn"  unless @currentUser.attemptAutoSignIn()

  showView: (name, data) ->
    @viewHandler.show name, data

  handleTasksLoaded: ->
    setTimeout (=> @showView "taskList", { state: "now" }), 100

$ -> window.app = new Application()
