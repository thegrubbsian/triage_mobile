class Views.TaskList extends Views.PageView

  initialize: ->
    @app = @options.app
    @state = @options.state
    @template = Templates.task_list

  render: ->
    @$el.html @template(state: @state)
    @$list = @$el.find("ul.list")
    @collection.eachInState @state, (task) => @renderItem(task)
    @initSorting()

  renderItem: (task) ->
    itemView = new Views.TaskItem(model: task, app: @app)
    itemView.render @$list

  initSorting: ->
    @$list.sortable
      axis: "y"
      handle: "span.order"
      update: (e, ui) => @handleSortUpdate(e, ui)

  handleSortUpdate: (e, ui) ->
    $item = $(ui.item)
    taskId = $item.data("id")
    taskBeforeId = ($item.prev().length > 0) && $item.prev().data("id")
    taskAfterId = ($item.next().length > 0) && $item.next().data("id")
    @collection.updateSortOrder(taskId, taskBeforeId, taskAfterId)
