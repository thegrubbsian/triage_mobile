class Views.Window extends Backbone.View

  events:
    "tap header #back-button": "handleBackButton"
    "tap header #settings-button": "handleSettingsButton"

  initialize: ->
    @app = @options.app

  handleBackButton: ->
    @trigger "goBack"

  handleSettingsButton: ->
    @trigger "showSettingsModal"
