
@PlanetExpress.module "BacklogApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      notdos = App.request "notdo:entities"

      App.execute "when:fetched", notdos, =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @backlogRegion notdos

        @show @layout

    titleRegion: ->
      title_view = @getTitleView()
      @layout.titleRegion.show title_view

    panelRegion: ->
      panel_view = @getPanelView()
      @layout.panelRegion.show panel_view

    backlogRegion: (notdos) ->
      backlog_view = @getBacklogListView notdos

      @listenTo backlog_view, "childview:notdo:item:clicked", (child, args) ->
        App.vent.trigger "notdo:item:clicked", args.model

      @listenTo backlog_view, "childview:notdo:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get('title')}?" then model.destroy()

      @layout.backlogRegion.show backlog_view

    getLayoutView: ->
      new List.Layout

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel

    getBacklogListView: (notdos) ->
      new List.BacklogList
        collection: notdos