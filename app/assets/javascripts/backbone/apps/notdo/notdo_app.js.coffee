# Top level methods, logic, and events that manage everything within 'NotdoApp'

@PlanetExpress.module "NotdoApp", (NotdoApp, App, Backbone, Marionette, $, _) ->

  # AppRouters are just a list of routes and a designated controller.
  # Point is to separate router from controller.
  class NotdoApp.Router extends Marionette.AppRouter
    appRoutes:
      "notdo/:id/edit" : "edit"
      "notdo"          : "list"

  API =
    list: ->
      new NotdoApp.List.Controller

    newNotdo: (region) ->
      new NotdoApp.New.Controller
        region: region

    # 2 entry points to edit page:
    # (1) User clicks notdo item in list page (we have the item)
    # (2) User points url to the route (we have item.id)
    edit: (id, member) ->
      new NotdoApp.Edit.Controller
        id: id
        member: member

  # When user clicks add, setup New module.
  App.commands.setHandler "new:notdo:item", (region) ->
    API.newNotdo region

  # When notdo item is clicked or created, redirect to edit page and update URL.
  App.vent.on "notdo:item:clicked notdo:created", (item) ->
    # Same as Backbone.history.navigate "notdo/#{item.id}/edit"
    App.navigate Routes.edit_notdo_path(item.id)
    API.edit item.id, item

  # When notdo item is cancelled or updated, go back to list page and update URL.
  App.vent.on "notdo:cancelled notdo:updated", (notdo) ->
    App.navigate Routes.notdo_index_path()
    API.list()

  App.addInitializer ->
    # Instantiate our appRouter and designate the controller.
    new NotdoApp.Router
      controller: API
