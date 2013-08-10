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

  Backbone.Model.prototype.saveLocal = function(key) {
    var id = this.id;
    if (typeof key !== "undefined") { id = key; }
    var storageKey = this.name + ":" + id;
    var attrs = JSON.stringify(this.attributes);
    Store.set(storageKey, attrs);
    return storageKey;
  };

  Backbone.Model.prototype.fetchLocal = function(key) {
    var id = this.id;
    if (typeof key !== "undefined") { id = key; }
    var storageKey = this.name + ":" + id;
    var attrs = Store.get(storageKey);
    var foundKey = false;
    if (attrs) {
      foundKey = true;
      this.set(JSON.parse(attrs));
    }
    return foundKey;
  };


})();
