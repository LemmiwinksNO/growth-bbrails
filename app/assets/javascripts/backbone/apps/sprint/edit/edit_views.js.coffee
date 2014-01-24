@PlanetExpress.module "SprintApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "sprint/edit/edit_layout"

    regions:
      formRegion:   "#form-region"
      titleRegion:  "#title-region"

  class Edit.Title extends App.Views.ItemView
    template: "sprint/edit/edit_title"

    # Custom model event from our model save method.
    # Purpose is to update title region when model updates.
    modelEvents:
      "updated" : "render"

  class Edit.Ticket extends App.Views.ItemView
    template: "sprint/edit/edit_ticket"

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

    # We can handle 'form:submit' event here. We fire it on this view
    # from formController, which is triggered when user hits submit on
    # the form.
    # We can use this to prevent the form from updating.
    # onFormSubmit: (data) ->

    # onFormCancel: (data) ->

    # Set form configuration here
    # form:
      # buttons: false  # No buttons at all for the form.
      # buttons:
        # primary: "foo"
        # cancel: false
        # placement: "left"