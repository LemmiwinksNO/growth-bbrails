@PlanetExpress.module "SprintApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: (options) ->
      ticket = App.request "new:ticket:entity"

      # Custom event from our custom save method (/entities/_base/models.js).
      # Clearer and safer than just binding to backbone's sync event.
      # Once item is created, forward custom event to parent app so we
      # can redirect user to edit page.
      @listenTo ticket, "created", ->
        App.vent.trigger "sprint:item:created", ticket

      newView = @getNewView ticket
      formView = App.request "form:wrapper", newView
        # can put custom form configurables here or with the view

      # Once form is closed, close the region.
      @listenTo newView, "form:cancel", =>
        @region.close()  # @region attached via App.Controllers.Base

      @show formView

    getNewView: (ticket) ->
      new New.Ticket
        model: ticket