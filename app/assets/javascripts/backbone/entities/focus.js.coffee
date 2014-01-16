@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Focus extends App.Entities.Model
    urlRoot: -> Routes.focus_path()

    # Each focus has procedures and projects, turn them into collections.
    parse: (response, options) ->
      response.projects = App.request "new:project:collection", response.projects
      response.procedures = App.request "new:procedure:collection", response.procedures
      # response.procedures = new Entities.ProcedureCollection response.procedures
      # response.projects   = new Entities.ProjectCollection   response.projects
      return response

  class Entities.FocusCollection extends App.Entities.Collection
    model: Entities.Focus

    url: -> Routes.focus_path()

  API =

    getFocuses: ->
      focuses = new Entities.FocusCollection
      focuses.fetch
        reset: true  # Fires 'reset' event (not silent)
      focuses

    getFocus: (id) ->
      focus = new Entities.Focus
        id: id
      focus.fetch()
      focus

    newFocus: ->
      new Entities.Focus

  App.reqres.setHandler "focus:entities", ->
    API.getFocuses()

  App.reqres.setHandler "focus:entitity", (id) ->
    API.getFocus id

  App.reqres.setHandler "new:focus:entity", ->
    API.newFocus()