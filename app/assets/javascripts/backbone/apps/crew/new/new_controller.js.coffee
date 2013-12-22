@PlanetExpress.module "CrewApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: (options) ->
      crew = App.request "new:crew:entity"

      # Custom event from our custom save method (/entities/_base/models.js).
      # Clearer and safer than just binding to backbone's sync event.
      # Once item is created, forward custom event to parent app so we
      # can redirect user to edit page.
      @listenTo crew, "created", ->
        App.vent.trigger "crew:created", crew

      newView = @getNewView crew
      formView = App.request "form:wrapper", newView
        # can put custom form configurables here or with the view

      # Now that this controller has access to the region, it can handle closing it.
      @listenTo newView, "form:cancel", =>
        @region.close()  # @region attached via App.Controllers.Base

      @show formView

    getNewView: (crew) ->
      new New.Crew
        model: crew
