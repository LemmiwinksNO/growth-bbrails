@PlanetExpress.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: ->
      listView = @getListView()
      @show listView

    getListView: ->
      new List.Header