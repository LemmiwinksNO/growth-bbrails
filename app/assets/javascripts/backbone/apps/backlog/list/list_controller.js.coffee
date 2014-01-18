
@PlanetExpress.module "BacklogApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->

      # Shouldn't we ALWAYS have App.User.focuses?
      @focuses = App.User.focuses
      # @focuses = App.request "focus:entities"

      App.execute "when:fetched", @focuses, =>

        @projects = App.User.projects
        @procedures = App.User.procedures
        @tickets = App.User.tickets

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @backlogRegion @focuses

        @show @layout

    titleRegion: ->
      title_view = @getTitleView()
      @layout.titleRegion.show title_view

    panelRegion: ->
      panel_view = @getPanelView()
      @layout.panelRegion.show panel_view

    backlogRegion: (collection) ->
      backlog_view = @getBacklogListView collection

      @listenTo backlog_view, "childview:backlog:item:clicked", (child, args) ->
        App.vent.trigger "backlog:item:clicked", args.model

      @listenTo backlog_view, "childview:backlog:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get('title')}?" then model.destroy()

      @layout.backlogRegion.show backlog_view

    getLayoutView: ->
      new List.Layout

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel

    getBacklogListView: (collection) ->
      new List.BacklogList
        collection: collection
        type: focus