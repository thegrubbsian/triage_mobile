class Views.Window extends Backbone.View

  events:
    "click header #back-button": "handleBackButton"
    "click header #settings-button": "handleSettingsButton"

  initialize: ->
    @app = @options.app

  handleBackButton: ->
    @trigger "goBack"

  handleSettingsButton: ->
    @trigger "showSettingsModal"
    @trigger "uiChanged"
