(function() {

  var Store = {
    get: function(key) {
      return window.localStorage.getItem(key);
    },
    set: function(key, value) {
      window.localStorage.setItem(key, value);
    },
    clear: function() {
      window.localStorage.clear();
    }
  };
  window.Store = Store;

})();
