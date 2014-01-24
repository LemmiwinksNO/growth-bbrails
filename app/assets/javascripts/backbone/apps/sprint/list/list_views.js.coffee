
# Views - Manage their DOM

@PlanetExpress.module "SprintApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "sprint/list/list_layout"

    regions:
      titleRegion:    "#title-region"
      panelRegion:    "#panel-region"
      newRegion:      "#new-region"
      notDoingRegion: "#notdoing-region"
      doingRegion:    "#doing-region"
      doneRegion:     "#done-region"

  class List.Title extends App.Views.ItemView
    template: "sprint/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "sprint/list/_panel"

    triggers:  # prevents default and stops propogation
      "click #new-ticket" : "new:sprint:button:clicked"

  class List.Ticket extends App.Views.ItemView
    template: "sprint/list/_ticket"
    tagName: "li"
    className: -> "item ellipsis " + @model.get 'status'

    triggers:
      "click"                : "sprint:item:clicked"
      "click .ticket-delete" : "sprint:delete:clicked"

  class List.Empty extends App.Views.ItemView
    template: "sprint/list/_empty"
    tagName: "li"
    className: "item"

  class List.SprintList extends App.Views.CompositeView
    template: "sprint/list/_sprint_list"
    itemView: List.Ticket
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
