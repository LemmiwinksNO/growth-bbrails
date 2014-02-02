@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
# Backend model is focus_area due to issues with Rails and Rabl and words that end
# in s. Focus pluralizes to focus for Rails and to focu for Rabl. If you can figure
# out a way around this, that would be cool. For Rails, You can set_table_name "focuses"
# in the focus model.

  class Entities.Focus extends App.Entities.Model
    urlRoot: -> Routes.focus_area_index_path()  #=> /focus_area

    # Each focus has procedures and projects, turn them into collections.
    parse: (response, options) ->
      response.projects = App.request "new:project:collection", response.projects
      response.procedures = App.request "new:procedure:collection", response.procedures
      return response

    # Create Collections from Arrays
    initialize: ->
      @set('projects', App.request "new:project:collection", @get('projects'))
      @set('procedures', App.request "new:procedure:collection", @get('procedures'))

  class Entities.FocusCollection extends App.Entities.Collection
    model: Entities.Focus

    url: -> Routes.focus_area_index_path()

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

    # Takes an array of objects and converts into a collection of models
    newFocusCollection: (objects) ->
      new Entities.FocusCollection objects

  App.reqres.setHandler "focus:entities", ->
    API.getFocuses()

  App.reqres.setHandler "focus:entitity", (id) ->
    API.getFocus id

  App.reqres.setHandler "new:focus:entity", ->
    API.newFocus()

  App.reqres.setHandler "new:focus:collection", (objects) ->
    API.newFocusCollection objects