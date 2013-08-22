class Models.Task extends Backbone.Model

  name: "Task"

  pastDue: ->
    now = new Date()
    dueAt = new Date(@get "due_at")
    now > dueAt

  displayDueAt: ->
    date = @get "due_at"
    moment(date).format("ddd, MMM Do, YYYY")
