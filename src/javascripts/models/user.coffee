class Models.User extends Backbone.Model

  name: "User"

  attemptAutoSignIn: ->
    localRecord = Store.get("currentUser")
    if localRecord
      @set JSON.parse(localRecord)
      @trigger "userSignedIn" if localRecord
    localRecord

  signIn: (data, options) ->
    $.ajax
      type: "POST"
      url: config.url("/sessions")
      data: data
      dataType: "json"
      success: (response) =>
        @set response
        Store.set("currentUser", JSON.stringify(@attributes))
        @trigger "userSignedIn"
        options.success() if options.success
      error: => options.error() if options.error

  signUp: (data, options) ->
    $.ajax
      type: "POST"
      url: config.url("/users")
      data:
        user: data
      dataType: "json"
      success: (response) =>
        @set response
        Store.set("currentUser", JSON.stringify(@attributes))
        @trigger "userSignedIn"
        opts.success() if options.success
      error: => options.error() if options.error
