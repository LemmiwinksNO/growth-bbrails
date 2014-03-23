@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends App.Entities.Model
    # urlRoot: -> Routes.user_path()
    urlRoot: -> Routes.user_index_path()  #=> /user

    # Each user has focuses, projects, tickets and procedures. Turn them into collections.
    parse: (response, options) ->
      response.focuses    = App.request "new:focus:collection", response.focus_areas
      response.projects   = App.request "new:project:collection", response.projects
      response.procedures = App.request "new:procedure:collection", response.procedures
      response.tickets    = App.request "new:ticket:collection", response.tickets

      # I'm using focuses rather than focus_areas
      delete response.focus_areas

      return response

  class Entities.UserCollection extends App.Entities.Collection
    model: Entities.User

    url: -> Routes.user_index_path()

  API =

    getUsers: ->
      users = new Entities.UserCollection
      users.fetch
        reset: true  # Fires 'reset' event (not silent)
      users

    getUser: (id) ->
      # TODO: Get id.
      id = id || 1
      user = new Entities.User
        id: id
      user.fetch()
      user

    newUser: ->
      new Entities.User

  App.reqres.setHandler "user:entities", ->
    API.getUsers()

  App.reqres.setHandler "user:entity", (id) ->
    API.getUser id

  App.reqres.setHandler "new:user:entity", ->
    API.newUser()