class Views.TaskItem extends Backbone.View

  events:
    tap: "handleTap"

  initialize: ->
    @app = @options.app
    @template = Templates.task_item

  render: ($list) ->
    @$el = $(@template(task: @model)).appendTo($list)
    @delegateEvents()

  handleTap: ->
    @app.showView "taskDetail",
      model: @model
