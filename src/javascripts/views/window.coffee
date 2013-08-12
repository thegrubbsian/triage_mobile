class Views.Window extends Backbone.View

  events:
    "tap header #back-button": "goBack"

  initialize: ->
    @app = @options.app

  goBack: ->
    @trigger "goBack"
