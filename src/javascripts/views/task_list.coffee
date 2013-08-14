class Views.TaskList extends Views.PageView

  events:
    "change #new-task-field": "handleNewTask"
    "click #tabs li": "changeTab"

  initialize: ->
    @app = @options.app
    @state = @options.state || "now"
    @template = Templates.task_list

  preRender: (data) ->
    @state = data.state

  render: ->
    @$el.html @template(state: @state)
    @renderList(@state)

  changeTab: (e) ->
    $li = $(e.target).closest("li")
    @$el.find("li.active").removeClass("active")
    $li.addClass("active")
    @state = $li.data("state")
    @renderList(@state)

  renderList: (state) ->
    $newList = $("<ul class='list'></ul>")
    @collection.eachInState @state, (task) => @renderItem(task, $newList)
    @$el.find("ul.list").replaceWith($newList)
    @initSorting()

  renderItem: (task, $list) ->
    itemView = new Views.TaskItem(model: task, app: @app)
    itemView.render $list

  initSorting: ->
    @$el.find("ul.list").sortable
      axis: "y"
      handle: "span.order"
      update: @handleSortUpdate

  handleSortUpdate: (e, ui) =>
    $item = $(ui.item)
    taskId = $item.data("id")
    taskBeforeId = ($item.prev().length > 0) && $item.prev().data("id")
    taskAfterId = ($item.next().length > 0) && $item.next().data("id")
    @collection.updateSortOrder(taskId, taskBeforeId, taskAfterId)

  handleNewTask: (e) ->
    $el = $(e.target)
    task = @app.tasks.create(name: $el.val())
    @app.showView "taskDetail", { model: task }
