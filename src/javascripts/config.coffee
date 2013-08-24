Config = ->

  environment = "development"
  appVersion = "1.0.0"
  apiVersion = "1.0.0"

  settings =
    development:
      serverUrl: "http://localhost:3000"
      syncInterval: 2000

    staging:
      serverUrl: "http://triage-app-staging.herokuapp.com"
      syncInterval: 10000

    production:
      serverUrl: "https://triage-app-production.herokuapp.com"
      syncInterval: 10000

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
