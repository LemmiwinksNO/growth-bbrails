# Top level methods, logic, and events that manage everything within 'SprintApp'

@PlanetExpress.module "SprintApp", (SprintApp, App, Backbone, Marionette, $, _) ->

  # AppRouters are just a list of routes and a designated controller.
  # Point is to separate router from controller.
  class SprintApp.Router extends Marionette.AppRouter
    appRoutes:
      "sprint/:id/edit" : "edit"
      "sprint"          : "list"

  API =
    list: ->
      new SprintApp.List.Controller

    newTicket: (region, collection) ->
      new SprintApp.New.Controller
        region: region
        collection: collection

    # 2 entry points to edit page:
    # (1) User clicks ticket in list page (we have the item)
    # (2) User points url to the route (we have item.id)
    edit: (id, item) ->
      new SprintApp.Edit.Controller
        id: id
        item: item

  # When user clicks add, setup New module.
  App.commands.setHandler "new:sprint:item", (region, collection) ->
    console.log collection
    API.newTicket region, collection

  # When ticket is clicked or created, redirect to edit page and update URL.
  App.vent.on "sprint:item:clicked sprint:item:created", (item) ->
    # App.navigate Routes.edit_notdo_path(item.id)
    App.navigate "sprint/#{item.id}/edit"
    API.edit item.id, item
    # App.vent.trigger "backlog:item:clicked", item, 'ticket'

  # When ticket is cancelled or updated, go back to list page and update URL.
  App.vent.on "sprint:item:cancelled sprint:item:updated", (item) ->
    App.navigate "sprint"
    # App.navigate Routes.notdo_index_path()
    API.list()

  App.addInitializer ->
    # Instantiate our appRouter and designate the controller.
    new SprintApp.Router
      controller: API
