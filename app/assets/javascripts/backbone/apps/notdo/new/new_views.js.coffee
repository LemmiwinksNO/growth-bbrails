@PlanetExpress.module "NotdoApp.New", (New, App, Backbone, Marionette, $, _) ->

    class New.Notdo extends App.Views.ItemView
      template: "notdo/new/new_notdo"

      # Custom form configurables
      form:
        buttons:
          placement: "left"