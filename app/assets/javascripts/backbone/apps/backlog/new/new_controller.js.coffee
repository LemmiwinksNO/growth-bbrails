@PlanetExpress.module "BacklogApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: ->
      type = @options.type

      # Create a new item (focus, project, ticket, procedure)
      item = App.request "new:#{type}:entity"

      # Once item is created, forward custom event to parent app so
      # we can redirect user to edit page.
      @listenTo item, "created", ->
        console.log "created backlog:item:created", item, type
        App.vent.trigger "backlog:item:created", item, type

      newView = @getNewView item, type
      formView = App.request "form:wrapper", newView
        # Can put custom form configurables here or within the view

      # Once form is closed, close the region
      @listenTo newView, 'form:cancel', =>
        @region.close()

      @show formView

    getNewView: (item, type) ->
      new New.BacklogItem
        model: item
        type: type