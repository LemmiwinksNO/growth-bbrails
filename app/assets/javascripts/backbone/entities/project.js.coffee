@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Project extends App.Entities.Model
    urlRoot: -> Routes.project_index_path()

    # Each project has tickets
    # This creates ticket collection from the ticket array, but only
    # when we fetch. (not when focus model creates ProjectCollection)
    # parse: (response, options) ->
    #   console.log "project parse"
    #   response.tickets = new Entities.TicketCollection response.tickets
    #   return response

    # Create TicketCollection from ticket array
    initialize: (model) ->
      @set('tickets', App.request "new:ticket:collection", model.tickets)
      # @set('tickets', new Entities.TicketCollection model.tickets)
      # @set('tickets', new Entities.TicketCollection @.get('tickets')) # same thing

  class Entities.ProjectCollection extends App.Entities.Collection
    model: Entities.Project

    urlRoot: -> Routes.project_index_path()

  API =

    # Takes an array of objects and converts into a collection of models
    newProjectCollection: (objects) ->
      new Entities.ProjectCollection objects

    newProject: ->
      new Entities.Project

  App.reqres.setHandler "new:project:collection", (objects) ->
    API.newProjectCollection objects

  App.reqres.setHandler "new:project:entity", ->
    API.newProject()