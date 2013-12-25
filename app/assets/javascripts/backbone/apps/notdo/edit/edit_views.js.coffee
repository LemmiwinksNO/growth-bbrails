@PlanetExpress.module "NotdoApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
  console.log "here"
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

    # This gets fired when controller triggers form:submit event.
    # We use this to prevent the form from updating.
    # onFormSubmit: (data) ->

    # Set form configuration here
    # form:
      # buttons: false  # No buttons at all for the form.
      # buttons:
        # primary: "foo"
        # cancel: false
        # placement: "left"