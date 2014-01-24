@PlanetExpress.module "SprintApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options) ->
      # Sets id and item from options.id and options.item
      { id, item } = options

      App.execute "when:fetched", App.User.focuses, =>
        { @tickets, @projects } = App.User

        item ?= @getItem id

        # "updated" is a event we added via our custom model save method
        @listenTo item, "updated", ->
          App.vent.trigger "sprint:item:updated", item

        @layout = @getLayoutView item

        # Load regions after layout shows
        @listenTo @layout, "show", =>
          @titleRegion item
          @formRegion item

        @show @layout

    getItem: (id) ->
      item = @tickets.get id

    titleRegion: (item) ->
      titleView = @getTitleView item
      @layout.titleRegion.show titleView

    formRegion: (item) ->
      editView = @getEditView item

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "sprint:item:cancelled", item

      # Wrap editView in a form
      formView = App.request "form:wrapper", editView,  # note the comma
        footer: true  # Controller overwrites view form config
        # Add form config here (or in view)

      @layout.formRegion.show formView

    getLayoutView: (item) ->
      new Edit.Layout
        model: item

    getTitleView: (item) ->
      new Edit.Title
        model: item

    getEditView: (item) ->
      new Edit.Ticket
        model: item
        projects: @projects

