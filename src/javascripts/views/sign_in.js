Views.SignIn = PageView.extend({

  events: {
    "tap #sign-in-button": "handleSignIn",
    "tap #sign-up-link": "handleSignUpLink"
  },

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
    this.template = Templates["sign_in"];
  },

  render: function() {
    this.$el.html(this.template());
  },

  handleSignIn: function() {
    var formData = Helpers.formData(this.$el.find("#sign-in-form"));
    this.app.currentUser.signIn(formData, {
      error: this.signInFailure
    });
  },

  signInFailure: function() {
    this.$el.find("#sign-in-error-message").show();
  },

  handleSignUpLink: function() {
    this.app.showView("signUp");
  }

});
