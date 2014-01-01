
# Views - Manage their DOM

@PlanetExpress.module "NotdoApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "notdo/list/list_layout"

    regions:
      titleRegion:    "#title-region"
      panelRegion:    "#panel-region"
      newRegion:      "#new-region"
      notDoingRegion: "#notdoing-region"
      doingRegion:    "#doing-region"
      doneRegion:     "#done-region"

  class List.Title extends App.Views.ItemView
    template: "notdo/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "notdo/list/_panel"

    triggers:  # prevents default and stops propogation
      "click #new-notdo" : "new:notdo:button:clicked"

  class List.NotdoItem extends App.Views.ItemView
    template: "notdo/list/_notdo_item"
    tagName: "li"
    className: -> "item ellipsis " + @model.get 'status'

    triggers:
      "click"               : "notdo:item:clicked"
      "click .notdo-delete" : "notdo:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "notdo/list/_empty"
    tagName: "li"
    className: "item"

  class List.NotdoList extends App.Views.CompositeView
    template: "notdo/list/_notdo_list"
    itemView: List.NotdoItem
    emptyView: List.Empty
    itemViewContainer: "ul.items"
    # className: -> @options.status
    # itemViewOptions: -> foo: 'bar',  Passed in to each model

    # You could filter collection down here.
    # initialize: ->
    #   @collection = @collection.doneCollection();

    # Results of this function are passed to the template
    serializeData: ->
      title: @options.title
      status: @options.status

    # The collection we pass in is filtered down to certain statuses (i.e. doing)
    # If the collection fetches for some reason, it might get all items unless you
    # filter it again in this method.
    # showCollection: ->
