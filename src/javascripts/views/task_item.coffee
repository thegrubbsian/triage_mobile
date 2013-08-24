class Views.TaskItem extends Backbone.View

  events:
    "click": "handleClick"
    "swipeleft": "handleSwipe"
    "click .delete": "handleDeleteClick"
    "click .archive": "handleArchiveClick"

  initialize: ->
    @app = @options.app
    @template = Templates.task_item
    @app.on "uiChanged", @hideSwiper

  render: ($list) ->
    @$el = $(@template(task: @model)).appendTo($list)
    @$swiper = @$el.find(".swiper")
    @delegateEvents()

  handleClick: (e) ->
    e.preventDefault()
    @app.showView "taskDetail", { model: @model }

  handleSwipe: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @trigger "uiChanged"
    @showSwiper()

  showSwiper: ->
    @$swiper.attr "class", "swiper show"
    @swiperOpen = true

  hideSwiper: =>
    @$swiper.attr "class", "swiper"
    @swiperOpen = false

  handleDeleteClick: (e) ->
    e.stopPropagation()
    @model.delete @handleArchiveDeleteComplete

  handleArchiveDeleteComplete: =>
    @$el.fadeOut(=> @remove())

  handleArchiveClick: (e) ->
    e.stopPropagation()
    @model.archive @handleArchiveDeleteComplete
