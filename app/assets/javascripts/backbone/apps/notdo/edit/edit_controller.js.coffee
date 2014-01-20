@PlanetExpress.module "NotdoApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options) ->
      # Sets id and item from options.id and options.item
      { id, item } = options

      # Use notdo item model if we have it, else request it.
      # Point is to only get the item model if we don't already have it.
      item or= App.request "notdo:entity", id

      # "updated" is a event we added via our custom model save method
      @listenTo item, "updated", ->
        App.vent.trigger "notdo:item:updated", item

      # When notdo item model finishes fetching, load the page
      App.execute "when:fetched", item, =>
        @layout = @getLayoutView item

        # Load regions after layout shows
        @listenTo @layout, "show", =>
          @titleRegion item
          @formRegion item

        @show @layout

    titleRegion: (item) ->
      titleView = @getTitleView item
      @layout.titleRegion.show titleView

    formRegion: (item) ->
      editView = @getEditView item

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "notdo:item:cancelled", item

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
      new Edit.Notdo
        model: item

