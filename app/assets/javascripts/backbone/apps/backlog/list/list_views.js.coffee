
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

    serializeData: ->
      type: @options.type

  class List.Panel extends App.Views.ItemView
    template: "backlog/list/_panel"

    # Set type dropdown
    onRender: ->
      type = @options.type
      this.$el.find("select[name='type'] option[value=" + type + "]").prop('selected', true)

    # Triggers -> Add Item; Type (what type to show); Filter
    triggers:
      "click #select-type"  : "backlog:type:selected"
      "click #new-item"     : "backlog:new:item:clicked"

  class List.BacklogItem extends App.Views.ItemView
    # Use template specific to model (4 template approach)
    getTemplate: ->
      "backlog/list/_#{@options.type}"

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
    emptyView: List.Empty
    itemView: List.BacklogItem
    itemViewContainer: "ul"
    itemViewOptions: ->
      type: @options.type

    # Use itemView specific to our model (4 ItemView approach)
    # getItemView: (item) ->
        # return List.BacklogItem
