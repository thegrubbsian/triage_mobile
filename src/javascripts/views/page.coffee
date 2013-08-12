class Views.PageView extends Backbone.View

  show: (data, isGoingBack) ->
    isGoingBack = false  if typeof isGoingBack is "undefined"
    if @preRender
      autoRender = @preRender(data, isGoingBack)
      if autoRender isnt false
        if @render
          @render()
          @in()
    else
      if @render
        @render()
        @in()

  release: ->
    @out()

  releaseComplete: =>
    @$el.empty()
    @$el.attr "class", "page left"
    @$el.off "webkitTransitionEnd"

  in: ->
    @$el.attr "class", "page transition center"

  out: ->
    @$el.attr "class", "page transition right"
    @$el.on "webkitTransitionEnd", @releaseComplete
