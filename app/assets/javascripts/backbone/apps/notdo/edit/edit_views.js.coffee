@PlanetExpress.module "NotdoApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "notdo/edit/edit_layout"

    regions:
      formRegion: "#form-region"
      titleRegion: "#title-region"

  class Edit.Title extends App.Views.ItemView
    template: "notdo/edit/edit_title"

    # Custom model event from our model save method.
    # Purpose is to update title region when model updates.
    modelEvents:
      "updated" : "render"

  class Edit.Notdo extends App.Views.ItemView
    template: "notdo/edit/edit_notdo"

    # Set the status for dropdown
    # Start jQuery text editor
    onRender: ->
      status = @model.get('status')
      this.$el.find("option[value=" + status + "]").prop('selected', true)

      this.$el.find(".jqte").jqte
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