@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Notdo extends App.Entities.Model
    # Need this when fetching a single Model
    urlRoot: -> Routes.notdo_index_path()

  class Entities.NotdoCollection extends App.Entities.Collection
    model: Entities.Notdo

    url: -> Routes.notdo_index_path()

  API =

    getNotdoCollection: ->
      notdo_collection = new Entities.NotdoCollection
      notdo_collection.fetch
        reset: true  # So reset event will fire, not silent.
      notdo_collection

    getNotdoItem: (id) ->
      notdo = new Entities.Notdo
        id: id
      notdo.fetch()
      notdo

    newNotdoItem: ->
      new Entities.Notdo

  App.reqres.setHandler "notdo:entities", ->
    API.getNotdos()

  App.reqres.setHandler "notdo:entity", (id) ->
    API.getNotdoItem id

  App.reqres.setHandler "new:notdo:entity", ->
    API.newNotdoItem()