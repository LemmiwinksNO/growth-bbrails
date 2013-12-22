
# Controllers <br>
# (1) Responsible for managing within a sub-module <br>
# (2) Instantiates and wires up views <br>
# (3) Manages entities <br>
# (4) responds to view events <br>
# (5) Bubbles up information to parent module <br>

@PlanetExpress.module "NotdoApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    # (1) Instantiate notdo_collection and fetch <br>
    # (2) Wait until notdo_collection is fetched <br>
    # (3) Get layout view <br>
    # (4) Wait until @layout's show event is fired before showing its regions <br>
    # (5) Show @layout in mainRegion and listen to its close event so we
    #     know to clean up this controller. <br>
    #       @listenTo @layout, "close", @close.
    #       App.mainRegion.show @layout
    initialize: ->
      notdo_collection = App.request "notdo:entities"

      App.execute "when:fetched", notdo_collection, =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()                  # or @showTitle?
          @panelRegion()                  # or @showPanel?
          @notdoRegion notdo_collection   # or @listNotdo?

        @show @layout

    titleRegion: ->
      title_view = @getTitleView()
      @layout.titleRegion.show title_view

    # (1) Get panel_view. <br>
    # (2) Listen for user clicking add in panelRegion, then setup new region. <br>
    # (3) Show panel_view in @layout.panelRegion <br>
    panelRegion: ->
      panel_view = @getPanelView()

      @listenTo panel_view, "new:notdo:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panel_view

    # Let Notdo.New module handle this region. <br>
    # (1) Fire off command to parent app, which will set up New module.
    newRegion: ->
      App.execute "new:notdo:item", @layout.newRegion

    # (1) Get notdo_view <br>
    # (2) Listen for user clicking a notdo item and redirect to edit page. <br>
    # (3) Listen for user clicking delete button on a notdo item and delete
    #     the model after user confirms. <br>
    #       args -> view instance, model, collection <br>
    # (4) Show notdo_view in @layout.notdoRegion
    notdoRegion: (notdo_collection) ->
      notdo_view = @getNotdoView notdo_collection

      @listenTo notdo_view, "childview:notdo:item:clicked", (child, args) ->
        App.vent.trigger "notdo:item:clicked", args.model

      @listenTo notdo_view, "childview:notdo:delete:click", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get("name")}?" then model.destroy() else false

      @layout.notdoRegion.show notdo_view

    getNotdoView: (notdo_collection) ->
      new List.Notdo
        collection: notdo_collection

    getLayoutView: ->
      new List.Layout

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel
