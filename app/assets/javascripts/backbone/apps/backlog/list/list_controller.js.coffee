
@PlanetExpress.module "BacklogApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: (options) ->

      # Type of backlog item (focus, project, ticket, procedure)
      type = options.type || 'focus'

      # This is more decoupled
      # user = App.User || App.request "user:entity"
      # App.execute "when:fetched", user, ->
      #   { @focuses, @projects, @tickets, @procedures } = user

      App.execute "when:fetched", App.User.focuses, =>

        { @focuses, @projects, @tickets, @procedures } = App.User

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion type
          @panelRegion type
          @backlogRegion type

        @show @layout

    titleRegion: (type) ->
      title_view = @getTitleView type
      @layout.titleRegion.show title_view

    # Buttons in panel region
    #  Add Item -> Adds a focus/procedure/project/ticket
    #  View Type -> Shows focuses/procedures/projects/tickets
    panelRegion: (type) ->
      panel_view = @getPanelView type

      # Add Item Button Clicked
      @listenTo panel_view, "backlog:new:item:clicked", (args) ->
        type = args.view.$el.find("#select-type").val()
        @newRegion type

      # View Type Button Clicked
      @listenTo panel_view, "backlog:type:selected", (args) ->
        type = args.view.$el.find("#select-type").val()
        @titleRegion type  # So breadcrumbs update
        @backlogRegion type
        App.navigate "/backlog/#{type}"

      @layout.panelRegion.show panel_view

    # Backlog.New module will handle this region.
    # Fire off command to parent app.
    newRegion: (type) ->
      collection = @getCollectionFromType type

      App.execute "backlog:new:item", @layout.newRegion, type, collection

    backlogRegion: (type) ->
      collection = @getCollectionFromType type

      backlog_view = @getBacklogListView collection, type

      @listenTo backlog_view, "childview:backlog:item:clicked", (child, args) ->
        App.vent.trigger "backlog:item:clicked", args.model, type

      @listenTo backlog_view, "childview:backlog:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get('title')}?" then model.destroy()

      @layout.backlogRegion.show backlog_view

    getCollectionFromType: (type) ->
      switch type
        when 'focus'      then collection = @focuses
        when 'project'    then collection = @projects
        when 'ticket'     then collection = @tickets
        when 'procedure'  then collection = @procedures

    getLayoutView: ->
      new List.Layout

    getTitleView: (type) ->
      new List.Title
        type: type

    getPanelView: (type) ->
      new List.Panel
        type: type

    getBacklogListView: (collection, type) ->
      new List.BacklogList
        collection: collection
        type: type