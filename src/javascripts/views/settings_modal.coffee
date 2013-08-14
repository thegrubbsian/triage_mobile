class Views.SettingsModal extends Backbone.View

  events:
    "click #settings-close-button": "handleCloseButton"
    "click #sign-out-button": "handleSignOutButton"

  initialize: ->
    @template = Templates.settings_modal

  show: ->
    @$el.html(@template())
    @$el.addClass("active")

  close: ->
    @$el.removeClass("active")

  handleCloseButton: ->
    @close()

  handleSignOutButton: ->
    @trigger "signOut"
    @close()
