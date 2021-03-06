class Views.SignIn extends Views.PageView

  events:
    "click #sign-in-button": "handleSignIn"
    "click #sign-up-link": "handleSignUpLink"

  initialize: ->
    @app = @options.app
    @template = Templates.sign_in

  render: ->
    @$el.html @template()

  handleSignIn: ->
    formData = Helpers.formData(@$el.find("#sign-in-form"))
    @app.currentUser.signIn formData, error: @signInFailure

  signInFailure: =>
    @$el.find("#sign-in-error-message").show()

  handleSignUpLink: ->
    @app.showView "signUp"
