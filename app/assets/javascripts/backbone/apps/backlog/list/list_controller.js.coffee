
@PlanetExpress.module "BacklogApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->

      # Shouldn't we ALWAYS have App.User.focuses?
      @focuses = App.User.focuses || App.request "focus:entities"

      # Type of backlog item (focus, project, ticket, procedure)
      type = @options.type || 'focus'

      App.execute "when:fetched", @focuses, =>

        @projects = App.User.projects
        @procedures = App.User.procedures
        @tickets = App.User.tickets

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion type
          @showBacklogRegion type

        @show @layout

    titleRegion: ->
      title_view = @getTitleView()
      @layout.titleRegion.show title_view

    # Buttons in panel region
    #  Add Item -> Adds a focus/procedure/project/ticket
    #  View Type -> Shows focuses/procedures/projects/tickets
    panelRegion: (type) ->
      panel_view = @getPanelView type

      # Add Item Button Clicked
      @listenTo panel_view, "backlog:new:item:clicked", (args) ->
        console.log "backlog:new:item:clicked", args

      # View Type Button Clicked
      @listenTo panel_view, "backlog:type:selected", (args) ->
        type = args.view.$el.find("#select-type").val()
        @showBacklogRegion(type)
        App.navigate "/backlog/#{type}"

      @layout.panelRegion.show panel_view

    showBacklogRegion: (type) ->
      switch type
        when 'project'    then @backlogRegion @projects, type
        when 'focus'      then @backlogRegion @focuses, type
        when 'ticket'     then @backlogRegion @tickets, type
        when 'procedure'  then @backlogRegion @procedures, type

    backlogRegion: (collection, type) ->
      backlog_view = @getBacklogListView collection, type

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

    getPanelView: (type) ->
      new List.Panel
        type: type

    getBacklogListView: (collection, type) ->
      new List.BacklogList
        collection: collection
        type: type