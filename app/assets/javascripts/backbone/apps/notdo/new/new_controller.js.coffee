@PlanetExpress.module "NotdoApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: (options) ->
      notdo = App.request "new:notdo:entity"

      # Custom event from our custom save method (/entities/_base/models.js).
      # Clearer and safer than just binding to backbone's sync event.
      # Once item is created, forward custom event to parent app so we
      # can redirect user to edit page.
      @listenTo notdo, "created", ->
        App.vent.trigger "notdo:created", notdo

      newView = @getNewView notdo
      formView = App.request "form:wrapper", newView
        # can put custom form configurables here or with the view

      # Once form is closed, close the region.
      @listenTo newView, "form:cancel", =>
        @region.close()  # @region attached via App.Controllers.Base

      @show formView

    getNewView: (notdo) ->
      new New.Notdo
        model: notdo