Config = ->
  environment = "development"
  version = "1.0.0"
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

window.config = new Config()
