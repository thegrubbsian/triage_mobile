class Views.PageView extends Backbone.View

  show: (data, isGoingBack) ->
    isGoingBack = isGoingBack ? false
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

  reload: ->

  back: ->
    @out("right")

  forward: ->
    @out("left")

  in: ->
    @$el.attr "class", "page transition center"

  out: (direction) ->
    @$el.attr "class", "page transition #{direction}"
    @$el.on "webkitTransitionEnd", @transitionComplete

  transitionComplete: =>
    @$el.empty()
    @$el.attr "class", "page left"
    @$el.off "webkitTransitionEnd"
