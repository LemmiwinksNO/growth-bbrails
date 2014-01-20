
@PlanetExpress.module "BacklogApp", (BacklogApp, App, Backbone, Marionette, $, _) ->

  class BacklogApp.Router extends Marionette.AppRouter
    appRoutes:
      "backlog"                     : "list"
      "backlog/:type"               : "list"  # i.e. backlog/focus
      "backlog/:type/:id/edit"      : "edit"  # i.e. backlog/focus/4/edit

  API =
    # Start List Controller passing in the type of entity to show.
    list: (type) ->
      type = type || 'focus'  # Set type if undefined

      new BacklogApp.List.Controller
        type: type

    newItem: (region, type, collection) ->
      new BacklogApp.New.Controller
        region: region
        type: type
        collection: collection

    # Start Edit Controller - edit a model
    # We start this up when a new item is added, or an item is clicked.
    # Routable.
    edit: (type, id, item) ->
      new BacklogApp.Edit.Controller
        type: type
        id: id
        item: item


  # Setup new module
  App.commands.setHandler "backlog:new:item", (region, type, collection) ->
    API.newItem region, type, collection

  # When a backlog item is created or clicked, redirect to edit page and update URL
  App.vent.on "backlog:item:clicked backlog:item:created", (item, type) ->
    App.navigate "backlog/#{type}/#{item.id}/edit"  # backlog/ticket/34/edit
    API.edit type, item.id, item

  # From edit mode, if a item is cancelled, updated, or deleted, go back to list.
  App.vent.on "backlog:item:cancelled backlog:item:updated backlog:item:destroyed", (item, type) ->
    App.navigate "backlog/#{type}"
    API.list type


  App.addInitializer ->
    new BacklogApp.Router
      controller: API
