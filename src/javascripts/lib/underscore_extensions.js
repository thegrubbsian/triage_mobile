(function() {

  // Restore old underscore bindAll behavior
  _.bindSelf = function(context) {
    var args = _.functions(context);
    args.unshift(context);
    _.bindAll.apply(_, args);
  };

})();
