class Models.User extends Backbone.Model

  name: "User"

  attemptAutoSignIn: ->
    hasLocalRecord = @fetchLocal("currentUser")
    @trigger "userSignedIn"  if hasLocalRecord
    hasLocalRecord

  signIn: (data, options) ->
    $.ajax
      type: "POST"
      url: config.url("/sessions")
      data: data
      dataType: "json"
      success: (response) =>
        @set response
        @saveLocal "currentUser"
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
        @saveLocal "currentUser"
        @trigger "userSignedIn"
        opts.success() if options.success
      error: => options.error() if options.error
