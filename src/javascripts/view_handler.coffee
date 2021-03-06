class App.ViewHandler extends Backbone.Base

  views: {}

  history: []

  current: ->
    return null if @history.length is 0
    @history[@history.length - 1]

  register: (name, view) ->
    @views[name] = view
    @proxyEvents view

  get: (name) ->
    @views[name]

  back: ->
    return if @history.length <= 1
    if @current()
      prevView = @history.pop()
      @get(prevView.name).back()
      @get(@current().name).show @current().data, true
    @trigger "changingView", @current().name

  show: (name, data) ->
    data = data ? {}
    return if @current() and @current().name is name
    @get(@current().name).forward() if @current()
    @history.push name: name, data: data
    @get(name).show data, false
    @trigger "changingView", @current().name
