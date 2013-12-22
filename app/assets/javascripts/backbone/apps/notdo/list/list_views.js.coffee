
# Views - Manage their DOM

@PlanetExpress.module "NotdoApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "notdo/list/list_layout"

    regions:
      titleRegion:  "#title-region"
      panelRegion:  "#panel-region"
      newRegion:    "#new-region"
      notdoRegion:  "#notdo-region"

  class List.Title extends App.Views.ItemView
    template: "notdo/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "notdo/list/_panel"

    triggers:  # prevents default and stops propogation
      "click #new-notdo" : "new:notdo:button:clicked"

  # Need to divide this up into several views.
  # (1) List.NotdoItem ItemView
  # (2) List.NotdoCollection Composite View (notdoing, doing, done)
  #   Pass in title;
  class List.Notdo extends App.Views.ItemView
    template: "notdo/list/_notdo"
