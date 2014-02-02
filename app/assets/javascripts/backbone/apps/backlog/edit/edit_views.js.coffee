@PlanetExpress.module "BacklogApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "backlog/edit/edit_layout"

    regions:
      formRegion:   "#form-region"
      titleRegion:  "#title-region"

  class Edit.Title extends App.Views.ItemView
    template: "backlog/edit/edit_title"

    # Custom model event from our model save method.
    # Purpose is to update title region when model updates.
    modelEvents:
      "updated" : "render"

    # Pass in type along with the model
    serializeData: ->
      object = @model.toJSON()
      object.type = @options.type
      return object

  class Edit.Focus extends App.Views.ItemView
    template: "backlog/edit/edit_focus"

    # Start jQuery text editor
    onRender: ->
      this.$el.find(".jqte").jqte
        sub:    false
        sup:    false
        format: false

  class Edit.Project extends App.Views.ItemView
    template: "backlog/edit/edit_project"

    # Send focus collection along with model
    serializeData: ->
      object = @model.toJSON()
      object.focuses = @options.focuses.toJSON()
      return object

    # Set focus dropdown
    # Start jQuery text editor
    onRender: ->
      focus_area_id = @model.get('focus_area_id')
      this.$("select[name='focus_area_id'] option[value=" + focus_area_id + "]").prop('selected', true)

      this.$(".jqte").jqte
        sub:    false
        sup:    false
        format: false

  class Edit.Ticket extends App.Views.ItemView
    template: "backlog/edit/edit_ticket"

    # Send project collection along with model
    serializeData: ->
      object = @model.toJSON()
      object.projects = @options.projects.toJSON()
      return object

    # Set priority, status, project dropdowns
    # Start jQuery text editor
    onRender: ->
      status = @model.get('status')
      priority = @model.get('priority')
      project_id = @model.get('project_id')

      this.$("select[name='status'] option[value=" + status + "]").prop('selected', true)
      this.$("select[name='priority'] option[value=" + priority + "]").prop('selected', true)
      this.$("select[name='project_id'] option[value=" + project_id + "]").prop('selected', true)

      this.$(".jqte").jqte
        sub:    false
        sup:    false
        format: false

  class Edit.Procedure extends App.Views.ItemView
    template: "backlog/edit/edit_procedure"

    # Send focus collection along with model
    serializeData: ->
      object = @model.toJSON()
      object.focuses = @options.focuses.toJSON()
      return object

    # Set focus dropdown
    # Start jQuery text editor
    onRender: ->
      focus_area_id = @model.get('focus_area_id')
      this.$("select[name='focus_area_id'] option[value=" + focus_area_id + "]").prop('selected', true)

      this.$(".jqte").jqte
        sub:    false
        sup:    false
        format: false