class Views.TaskDetail extends Views.PageView

  events:
    "tap #save-button": "handleSave"
    "tap #state-selector a": "handleStateSelected"

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
    @app.showView "#{@model.get("state")}List"

  handleStateSelected: (e) ->
    @clearStateSelection()
    $el = $(e.target)
    $el.find("input").attr("checked", "checked")

  clearStateSelection: ->
    $stateSelector = @$el.find "#state-selector"
    $stateSelector.find("input[type='radio']").removeAttr("checked")
