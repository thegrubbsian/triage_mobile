class Collections.Tasks extends Backbone.Collection

  model: Models.Task
  url: config.url("/tasks")

  initialize: ->
    @storage = new Offline.Storage("triage:tasks", @, autoPush: true)
    @initSync()

  initSync: ->
    setInterval((=> @synchronize()), config.get("syncInterval"))

  synchronize: (options) ->
    @storage.sync.incremental(options)

  comparator: (task) ->
    task.get("order_index") * -1

  tasksInState: (state) ->
    @sort().where(state: state)

  eachInState: (state, func) ->
    _(@tasksInState(state)).each func

  updateSortOrder: (taskId, taskBeforeId, taskAfterId) ->
    task = @get(taskId)
    beforeTask = @get(taskBeforeId)
    beforeIdx = (beforeTask && beforeTask.get("order_index")) ||
      (@maxOrderInState(task.get("state")) + 1.00)
    afterTask = @get(taskAfterId)
    afterIdx = (afterTask && afterTask.get("order_index")) || 0.00
    newIdx = (afterIdx + beforeIdx) / 2
    task.set("order_index", newIdx)
    task.save()

  maxOrderInState: (state) ->
    maxTask = _(@tasksInState(state)).max (task) ->
      task.get("order_index")
    (maxTask && maxTask.get("order_index")) || 0
