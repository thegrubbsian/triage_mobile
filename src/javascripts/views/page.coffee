class Views.PageView extends Backbone.View

  show: (data, isGoingBack) ->
    isGoingBack = false  if typeof isGoingBack is "undefined"
    if @preRender
      autoRender = @preRender(data, isGoingBack)
      if autoRender isnt false
        if @render
          @render()
          @fadeIn()
    else
      if @render
        @render()
        @fadeIn()

  fadeIn: ->
    $(".page.in").removeClass "in"
    @$el.removeClass("out").addClass "in"

  release: ->
    @fadeOut()
    setTimeout @releaseComplete, 300

  releaseComplete: ->
    @$el.empty()

  fadeOut: ->
    $(".page.out").removeClass "out"
    @$el.addClass "out"
