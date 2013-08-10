var Config = function() {

  var environment = "development";
  var version = "1.0.0";

  var settings = {
    development: {
      serverUrl: "http://localhost:3000"
    },
    staging: {
      serverUrl: "http://galrme-staging.herokuapp.com"
    },
    production: {
      serverUrl: "https://galrme-production.herokuapp.com"
    }
  };

  return {
    setEnv: function(env) { environment = env; },
    version: function() { return version; },
    get: function(key) { return settings[environment][key]; },
    url: function(path) { return settings[environment]["serverUrl"] + path; }
  };

};

window.config = new Config();
