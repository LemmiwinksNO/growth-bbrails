@PlanetExpress.module "SprintApp.New", (New, App, Backbone, Marionette, $, _) ->

    class New.Ticket extends App.Views.ItemView
      template: "sprint/new/new_ticket"

      # Custom form configurables
      form:
        buttons:
          placement: "left"