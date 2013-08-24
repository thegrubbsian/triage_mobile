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

  showSpinner: ->
    options =
      lines: 13
      length: 20
      width: 4
      radius: 21
      corners: 1
      rotate: 0
      direction: 1
      color: "#000"
      speed: 1
      trail: 60
      shadow: false
      hwaccel: false
      className: "spinner"
      zIndex: 2e9
      top: "auto"
      left: "auto"
    $spinner = $el.find "#spinner .spin"
    spinner = new Spinner(options).spin $spinner
    $spinner.css "show"
