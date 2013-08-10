Models.User = Backbone.Model.extend({

  name: "User",

  attemptAutoSignIn: function() {
    var hasLocalRecord = this.fetchLocal("currentUser");
    if (hasLocalRecord) { this.trigger("userSignedIn"); }
    return hasLocalRecord;
  },

  signIn: function(data, options) {
    var opts = _.extend({ success: function() {}, error: function() {} }, options);
    var _self = this;
    $.ajax({
      type: "POST",
      url: config.url("/sessions"),
      data: data,
      dataType: "json",
      success: function(response) {
        _self.set(response);
        _self.saveLocal("currentUser");
        _self.trigger("userSignedIn");
        opts.success();
      },
      error: opts.error
    });
  },

  signUp: function(data, options) {
    var opts = _.extend({ success: function() {}, error: function() {} }, options);
    var _self = this;
    $.ajax({
      type: "POST",
      url: config.url("/users"),
      data: { user: data },
      dataType: "json",
      success: function(response) {
        _self.set(response);
        _self.saveLocal("currentUser");
        _self.trigger("userSignedIn");
        opts.success();
      },
      error: opts.error
    });
  }

});
