
@PlanetExpress.module "BacklogApp2", (BacklogApp2, App, Backbone, Marionette, $, _) ->

  class BacklogApp2.Router extends Marionette.AppRouter
    # appRoutes:
    #   "backlog" : "list"

  API =
    list: ->
      new BacklogApp2.List.Controller

  App.addInitializer ->
    new BacklogApp2.Router
      controller: API