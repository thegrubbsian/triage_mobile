class Views.TaskDetail extends Views.PageView

  initialize: ->
    @app = @options.app
    @template = Templates.task_detail

  preRender: (data) ->
    @model = data.model

  render: ->
    @$el.html @template(task: @model)
