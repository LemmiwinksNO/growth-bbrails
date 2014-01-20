@PlanetExpress.module "BacklogApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.BacklogItem extends App.Views.ItemView
    # template: "backlog/new/new_item"

    getTemplate: ->
      "backlog/new/new_#{@options.type}"

    # Custom form configurables
    form:
      buttons:
        placement: "left"