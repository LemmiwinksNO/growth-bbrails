
@PlanetExpress.module "BacklogApp", (BacklogApp, App, Backbone, Marionette, $, _) ->

  class BacklogApp.Router extends Marionette.AppRouter
    appRoutes:
      "backlog"            : "list"
      "backlog/focus"      : "list"
      "backlog/project"    : "list"
      "backlog/ticket"     : "list"
      "backlog/procedure"  : "list"

  API =
    # Start List Controller passing in the type of entity to show.
    list: ->
      frag = Backbone.history.fragment
      type = frag.match(/[^backlog/].*/)  # Match everything after backlog\/ (could be null)
      if type then type = type[0] else type = 'focus'

      new BacklogApp.List.Controller
        type: type


  App.addInitializer ->
    new BacklogApp.Router
      controller: API
