(function() {

  Backbone.Events.proxyEvents = function(source, namespace) {
    var _self = this;
    if (!_self.__proxySources) { _self.__proxySources = []; }
    if (_(_self.__proxySources).include(source)) { return; }
    _self.__proxySources.push(source);
    var handler = function(evt) {
      var args = Array.prototype.slice.apply(arguments).splice(1);
      if (namespace) { evt = namespace + ":" + evt; }
      args.unshift(evt);
      _self.trigger.apply(_self, arguments);
    };
    source.on("all", handler);
    return this;
  };

  Backbone.Events.rebind = function(evt, func) {
    this.off(evt, func);
    this.on(evt, func);
  };

  _([Backbone.Model, Backbone.Collection, Backbone.View,
    Backbone.Router, Backbone.Base])
  .each(function(klass) {
    klass.prototype.proxyEvents = Backbone.Events.proxyEvents;
    klass.prototype.rebind = Backbone.Events.rebind;
  });

  Backbone.Model.prototype.hasValue = function(field) {
    return this.has("field") && this.get("field").length > 0;
  };

})();
