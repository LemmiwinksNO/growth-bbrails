@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Ticket extends App.Entities.Model
    urlRoot: -> Routes.ticket_index_path()

  class Entities.TicketCollection extends App.Entities.Collection
    model: Entities.Ticket

    urlRoot: -> Routes.ticket_index_path()

  # Will need filter methods

  API =

    newTicketCollection: (objects) ->
      new Entities.TicketCollection objects

    newTicket: ->
      new Entities.Ticket

  App.reqres.setHandler "new:ticket:collection", (objects) ->
    API.newTicketCollection objects

  App.reqres.setHandler "new:ticket:entity", ->
    API.newTicket()