class Views.SignUp extends Views.PageView

  events:
    "click #sign-up-button": "handleSignUp"
    "click #sign-in-link": "handleSignInLink"

  initialize: ->
    @app = @options.app
    @template = Templates.sign_up

  render: ->
    @$el.html @template()

  handleSignUp: ->
    formData = Helpers.formData(@$el.find("#sign-up-form"))
    @app.currentUser.signUp formData, error: @signUpFailure

  signUpFailure: =>
    @$el.find("#sign-up-error-message").show()

  handleSignInLink: ->
    @app.showView "signIn"
