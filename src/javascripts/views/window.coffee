class Views.Window extends Backbone.View

  events:
    "tap header #back-button": "goBack"
    "tap #tabs li": "changeTab"

  initialize: ->
    @app = @options.app

  goBack: ->
    @trigger "goBack"

  changeTab: (e) ->
    state = $(e.target).closest("li").data("state")
    @app.showView "#{state}List"
