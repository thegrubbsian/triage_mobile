class Models.Task extends Backbone.Model

  name: "Task"

  pastDue: ->
    now = new Date()
    dueAt = new Date(@get "due_at")
    now > dueAt

  delete: (cb) ->
    navigator.notification.confirm "Are you sure you want to delete this task?",
      (=> @handleDeleteConfirmation(cb)), "Confirm Delete", ["Yes", "No"]

  archive: (cb) ->
    navigator.notification.confirm "Are you sure you want to archive this task?",
      (=> @handleArchiveConfirmation(cb)), "Confirm Archive", ["Yes", "No"]

  handleArchiveConfirmation: (cb) =>
    @save state: "archived"
    cb()

  handleDeleteConfirmation: (cb) =>
    @destroy()
    cb()
