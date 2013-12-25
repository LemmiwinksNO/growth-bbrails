@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Notdo extends App.Entities.Model
    # Need this when fetching a single Model
    urlRoot: -> Routes.notdo_index_path()

    # idAttribute: "guid"

    # defaults: {
    #   id: '',
    #   title: '',
    #   description: '',
    #   status: '',
    #   project: ''
    # }

  class Entities.NotdoCollection extends App.Entities.Collection
    model: Entities.Notdo

    url: -> Routes.notdo_index_path()

    # Maintain collection in sorted order
    comparator: (notdo) -> notdo.get "status"

    # Filter methods
    backlog: ->   @filter (notdo) -> notdo.get('status') == 'backlog'
    notDoing: ->  @filter (notdo) -> notdo.get('status') == 'not-doing'
    doing: ->     @filter (notdo) -> notdo.get('status') == 'doing'
    done: ->      @filter (notdo) -> notdo.get('status') == 'done'
    finished: ->  @filter (notdo) -> notdo.get('status') == 'finished'

    # Wrap filter results in a collection
    backlogCollection: ->   new Entities.NotdoCollection @backlog()
    notDoingCollection: ->  new Entities.NotdoCollection @notDoing()
    doingCollection: ->     new Entities.NotdoCollection @doing()
    doneCollection: ->      new Entities.NotdoCollection @done()
    finishedCollection: ->  new Entities.NotdoCollection @finished()

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
    API.getNotdoCollection()

  App.reqres.setHandler "notdo:entity", (id) ->
    API.getNotdoItem id

  App.reqres.setHandler "new:notdo:entity", ->
    API.newNotdoItem()