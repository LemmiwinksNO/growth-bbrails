
@PlanetExpress.module "BacklogApp2.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "backlog2/list/list_layout"

    regions:
      titleRegion:    '#title-region'
      panelRegion:    '#panel-region'
      newRegion:      '#new-region'
      backlogRegion:  '#backlog-region'

  class List.Title extends App.Views.ItemView
    template: "backlog2/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "backlog2/list/_panel"

    # Need two triggers -> #new_notdo and #new_project

  class List.BacklogItem extends App.Views.ItemView
    template: "backlog2/list/_backlog_item"
    tagName:  "li"
    className: -> "ellipsis " + @model.get 'status'

    # two triggers -> click the item, and click delete button
    triggers:
      "click"               : "notdo:item:clicked"
      "click .notdo-delete" : "notdo:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "backlog2/list/_empty"
    tagName:  "li"

  class List.BacklogList extends App.Views.CompositeView
    template: "backlog2/list/_backlog_list"
    itemView: List.BacklogItem
    emptyView: List.Empty
    itemViewContainer: "ul"