@PlanetExpress.module "CrewApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: (options) ->
      crew = App.request "new:crew:entity"

      # This event gets fired by our custom save method. We can forward it to
      # the parent app so we can redirect user to edit page.
      @listenTo crew, "created", ->
        App.vent.trigger "crew:created", crew

      newView = @getNewView crew
      formView = App.request "form:wrapper", newView
        # Custom form stuff goes here

      # Now that this controller has access to the region, it can handle closing it.
      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (crew) ->
      new New.Crew
        model: crew
