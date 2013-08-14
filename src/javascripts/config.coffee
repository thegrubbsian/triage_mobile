Config = ->

  environment = "development"
  appVersion = "1.0.0"
  apiVersion = "1.0.0"

  settings =
    development:
      serverUrl: "http://localhost:3000"

    staging:
      serverUrl: "http://galrme-staging.herokuapp.com"

    production:
      serverUrl: "https://galrme-production.herokuapp.com"

  setEnv: (env) ->
    environment = env

  version: ->
    version

  get: (key) ->
    settings[environment][key]

  url: (path) ->
    settings[environment]["serverUrl"] + path

  platform: ->
    return device.platform unless typeof device == "undefined"
    "browser"

window.config = new Config()
