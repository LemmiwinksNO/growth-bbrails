
@PlanetExpress.module "BacklogApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "backlog/list/list_layout"

    regions:
      titleRegion:    '#title-region'
      panelRegion:    '#panel-region'
      newRegion:      '#new-region'
      backlogRegion:  '#backlog-region'

  class List.Title extends App.Views.ItemView
    template: "backlog/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "backlog/list/_panel"

    # Need two triggers -> #new_notdo and #new_project

  class List.BacklogItem extends App.Views.ItemView
    template: "backlog/list/_backlog_item"
    tagName:  "li"
    className: -> "ellipsis " + @model.get 'status'

    # two triggers -> click the item, and click delete button
    triggers:
      "click"               : "notdo:item:clicked"
      "click .notdo-delete" : "notdo:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "backlog/list/_empty"
    tagName:  "li"

  class List.BacklogList extends App.Views.CompositeView
    template: "backlog/list/_backlog_list"
    itemView: List.BacklogItem
    emptyView: List.Empty
    itemViewContainer: "ul"