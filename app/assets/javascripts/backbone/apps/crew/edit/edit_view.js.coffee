@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "crew/edit/edit_layout"

    regions:
      formRegion: "#form-region"
      titleRegion: "#title-region"

  class Edit.Title extends App.Views.ItemView
    template: "crew/edit/edit_title"

    # Our custom updated event triggered in custom save method.
    # This updates the title region when the model updates.
    modelEvents:
      "updated" : "render"

  class Edit.Crew extends App.Views.ItemView
    template: "crew/edit/edit_crew"

    # This gets fired when controller triggers form:submit event.
    # We use this to prevent the form from updating.
    # onFormSubmit: (data) ->
    #   console.log "Edit.Crew onFormSubmit", data
    #   false

    # Set form configuration here
    # form:
      # buttons: false  # No buttons at all for the form.
      # buttons:
        # primary: "foo"
        # cancel: false
        # placement: "left"
