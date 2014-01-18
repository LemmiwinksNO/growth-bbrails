
@PlanetExpress.module "BacklogApp", (BacklogApp, App, Backbone, Marionette, $, _) ->

  class BacklogApp.Router extends Marionette.AppRouter
    appRoutes:
      "backlog" : "list"

  API =
    list: ->
      new BacklogApp.List.Controller

  App.addInitializer ->
    new BacklogApp.Router
      controller: API
