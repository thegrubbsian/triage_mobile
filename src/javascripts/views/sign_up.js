Views.SignUp = PageView.extend({

  events: {
    "tap #sign-up-button": "handleSignUp",
    "tap #sign-in-link": "handleSignInLink"
  },

  initialize: function() {
    _.bindSelf(this);
    this.app = this.options.app;
    this.template = Templates["sign_up"];
  },

  render: function() {
    this.$el.html(this.template());
  },

  handleSignUp: function() {
    var formData = Helpers.formData(this.$el.find("#sign-up-form"));
    this.app.currentUser.signUp(formData, {
      error: this.signUpFailure
    });
  },

  signUpFailure: function() {
    this.$el.find("#sign-up-error-message").show();
  },

  handleSignInLink: function() {
    this.app.showView("signIn");
  }

});
