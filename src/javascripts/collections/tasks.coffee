class Collections.Tasks extends Backbone.Collection

  model: Models.Task

  url: config.url("/tasks")

  eachInState: (state, func) ->
    models = @where(state: state)
    _(models).each func

  updateSortOrder: (taskId, taskBeforeId, taskAfterId) ->
    beforeTask = @get(taskBeforeId)
    beforeIdx = (beforeTask && beforeTask.get("order_index")) || (@maxOrder() + 1.00)
    afterTask = @get(taskAfterId)
    afterIdx = (afterTask && afterTask.get("order_index")) || 0.00
    task = @get(taskId)
    newIdx = (afterIdx + beforeIdx) / 2
    task.set("order_index", newIdx)
    task.save()

  maxOrder: ->
    @max (task) ->
      task.get("order_index")
