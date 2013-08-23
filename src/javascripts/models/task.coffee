class Models.Task extends Backbone.Model

  name: "Task"

  pastDue: ->
    now = new Date()
    dueAt = new Date(@get "due_at")
    now > dueAt

  archive: ->
    @set("state", "archived")
    @save()
