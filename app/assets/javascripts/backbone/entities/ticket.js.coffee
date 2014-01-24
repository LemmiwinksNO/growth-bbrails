@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Ticket extends App.Entities.Model
    urlRoot: -> Routes.ticket_index_path()

  class Entities.TicketCollection extends App.Entities.Collection
    model: Entities.Ticket

    urlRoot: -> Routes.ticket_index_path()

    # Maintain collection in sorted order
    comparator: (ticket) -> ticket.get "status"

    # Filter methods
    filterByStatus: (status) ->
      @filter (ticket) -> ticket.get('status') == status

    # Wrap filter results in a collection
    filterByStatusCollection: (status) ->
      new Entities.TicketCollection @filterByStatus(status)

  API =

    newTicketCollection: (objects) ->
      new Entities.TicketCollection objects

    newTicket: ->
      new Entities.Ticket

  App.reqres.setHandler "new:ticket:collection", (objects) ->
    API.newTicketCollection objects

  App.reqres.setHandler "new:ticket:entity", ->
    API.newTicket()