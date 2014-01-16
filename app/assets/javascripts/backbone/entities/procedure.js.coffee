@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Procedure extends App.Entities.Model
    urlRoot: -> Routes.procedure_index_path()

  class Entities.ProcedureCollection extends App.Entities.Collection
    model: Entities.Procedure

    urlRoot: -> Routes.procedure_index_path()

  API =

    # Takes an array of objects and converts into a collection of models
    newProcedureCollection: (objects) ->
      new Entities.ProcedureCollection objects

    newProcedure: ->
      new Entities.Procedure

  App.reqres.setHandler "new:procedure:collection", (objects) ->
    API.newProcedureCollection objects

  App.reqres.setHandler "new:procedure:entity", ->
    API.newProcedure()