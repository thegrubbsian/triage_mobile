class Views.TaskDetail extends Views.PageView

  events:
    "click #save-button": "handleSave"
    "click #state-selector a": "handleStateSelected"
    "click #delete-button": "handleDeleteButton"
    "click #archive-button": "handleArchiveButton"

  initialize: ->
    @app = @options.app
    @template = Templates.task_detail

  preRender: (data) ->
    @model = data.model

  render: ->
    @$el.html @template(task: @model)

  handleSave: ->
    $form = @$el.find "form"
    taskAttrs = Helpers.formData $form
    @model.save taskAttrs
    @showTaskList()

  handleStateSelected: (e) ->
    @clearStateSelection()
    $el = $(e.target)
    $el.find("input").attr "checked", "checked"

  clearStateSelection: ->
    $stateSelector = @$el.find "#state-selector"
    $stateSelector.find("input[type='radio']").removeAttr "checked"

  handleDeleteButton: ->
    @model.delete @handleDeleteComplete

  handleDeleteComplete: =>
    @showTaskList()

  handleArchiveButton: ->
    @model.archive @handleArchiveComplete

  handleArchiveComplete: =>
    @showTaskList "now"

  showTaskList: (state) ->
    state = @model.get("state") unless state
    @app.showView "taskList", { state: state }
