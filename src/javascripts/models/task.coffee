class Models.Task extends Backbone.Model

  name: "Task"

  pastDue: ->
    now = new Date()
    dueAt = new Date(@get "due_at")
    now > dueAt

  delete: (cb) ->
    navigator.notification.confirm "Are you sure you want to delete this task?",
      ((btn) => @handleDeleteConfirmation(btn, cb)), "Confirm Delete", ["Yes", "No"]

  archive: (cb) ->
    navigator.notification.confirm "Are you sure you want to archive this task?",
      ((btn) => @handleArchiveConfirmation(btn, cb)), "Confirm Archive", ["Yes", "No"]

  handleArchiveConfirmation: (btn, cb) =>
    if (btn == 1)
      @save state: "archived"
      cb()

  handleDeleteConfirmation: (btn, cb) =>
    if (btn == 1)
      @destroy()
      cb()
