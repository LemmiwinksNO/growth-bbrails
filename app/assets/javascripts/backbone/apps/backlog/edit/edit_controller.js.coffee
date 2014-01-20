@PlanetExpress.module "BacklogApp.Edit", (Edit, App, Marionette, Backbone, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options) ->
      { id, item, type } = options

      # Once we have all our data, set it on the controller.
      # Use item if it was passed in, otherwise get it.
      # Load the page.
      App.execute "when:fetched", App.User.focuses, =>
        { @focuses, @projects, @tickets, @procedures } = App.User

        if item then item else item = @getItem type, id

        @listenTo item, 'all', (event_name) ->
          console.log "Event name = ", event_name

        # "updated" is a event we added via our custom model save method
        @listenTo item, "updated", ->
          App.vent.trigger "backlog:item:updated", item, type

        # When model is destroyed
        @listenTo item, "destroy", ->
          App.vent.trigger "backlog:item:destroyed", item, type

        @layout = @getLayoutView item

        # Load regions after layout shows
        @listenTo @layout, "show", =>
          @titleRegion item, type
          @formRegion item, type

        @show @layout

    getItem: (type, id) ->
      switch type
        when 'focus'      then item = @focuses.get id
        when 'project'    then item = @projects.get id
        when 'ticket'     then item = @tickets.get id
        when 'procedure'  then item = @procedures.get id

    titleRegion: (item, type) ->
      titleView = @getTitleView item, type
      @layout.titleRegion.show titleView

    formRegion: (item, type) ->
      editView = @getEditView item, type

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "backlog:item:cancelled", item, type

      # Wrap editView in a form
      formView = App.request "form:wrapper", editView,  # note the comma
        footer: true  # Controller config overwrites form config

      @layout.formRegion.show formView

    getLayoutView: (item) ->
      new Edit.Layout
        model: item

    getTitleView: (item, type) ->
      new Edit.Title
        model: item
        type: type

    # Get the ItemView based on type
    # NOTE: Could do one ItemView with 4 templates and some variable stuff
    # in onRender.
    getEditView: (item, type) ->
      switch type
        when 'focus'      then new Edit.Focus     { model: item }
        when 'project'    then new Edit.Project   { model: item, focuses: @focuses }
        when 'ticket'     then new Edit.Ticket    { model: item, projects: @projects }
        when 'procedure'  then new Edit.Procedure { model: item, focuses: @focuses }
