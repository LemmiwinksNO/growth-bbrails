
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

    # Triggers -> Add Item; Type (what type to show); Filter

  class List.BacklogItem extends App.Views.ItemView
    # template: "backlog/list/_backlog_item"

    # Use template specific to model (4 template approach)
    getTemplate: () ->
      switch @options.type
        when 'focus'     then 'backlog/list/_focus'
        when 'project'   then 'backlog/list/_project'
        when 'ticket'    then 'backlog/list/_ticket'
        when 'procedure' then 'backlog/list/_procedure'
        else 'backlog/list/_focus'

    tagName:  "li"
    className: -> "ellipsis " + @model.get 'status'

    # two triggers -> click the item, and click delete button
    triggers:
      "click"                 : "backlog:item:clicked"
      "click .backlog-delete" : "backlog:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "backlog/list/_empty"
    tagName:  "li"

  class List.BacklogList extends App.Views.CompositeView
    template: "backlog/list/_list"
    itemView: List.BacklogItem

    # Use itemView specific to our model (4 ItemView approach)
    # getItemView: (item) ->
        # return List.BacklogItem

    emptyView: List.Empty
    itemViewContainer: "ul"
    itemViewOptions: ->
        type: "will probably put @type"

    # If you passed in type -> @options.type
    # itemViewOptions: ->  # Pass options to each itemView.
    #   type: @options.type
