module = (name) ->
  window[name] = window[name] or {}

module "App"
module "Models"
module "Collections"
module "Views"
