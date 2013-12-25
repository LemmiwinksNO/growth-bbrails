# Top level methods, logic, and events that manage everything within 'CrewApp'

@PlanetExpress.module "CrewApp", (CrewApp, App, Backbone, Marionette, $, _) ->

  # AppRouters are just a list of routes and a designated controller.
  # Point is to separate router from controller.
  class CrewApp.Router extends Marionette.AppRouter
    appRoutes:
      "crew/:id/edit" : "edit"
      "crew"          : "list"

  API =
    list: ->
      new CrewApp.List.Controller

    newCrew: (region) ->
      new CrewApp.New.Controller
        region: region

    # 2 entry points to edit page:
    # (1) User clicks crew member in list page (we have the member)
    # (2) User points url to the route (we have member.id)
    edit: (id, member) ->
      new CrewApp.Edit.Controller
        id: id
        member: member

  # When user clicks add, setup New module.
  App.commands.setHandler "new:crew:member", (region) ->
    API.newCrew region

  # When crew member is clicked or created, redirect to edit page and update URL.
  App.vent.on "crew:member:clicked crew:member:created", (member) ->
    App.navigate Routes.edit_crew_path(member.id)
    API.edit member.id, member

  # When crew member is cancelled or updated, go back to list page and update URL.
  App.vent.on "crew:member:cancelled crew:member:updated", (crew) ->
    App.navigate Routes.crew_index_path()
    API.list()

  App.addInitializer ->
    # Instantiate our appRouter and designate the controller.
    new CrewApp.Router
      controller: API
