@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options) ->
      { crew, id } = options
      # Use crew if we have it, else request it.
      # Need latter when user routes directly to edit.
      crew or= App.request "crew:entity", id

      @listenTo crew, "updated", ->
        console.log "crew updated"
        App.vent.trigger "crew:updated", crew

      # Don't load the eidt page until crew model is fetched.
      App.execute "when:fetched", crew, =>
        @layout = @getLayoutView crew

        @listenTo @layout, "show", =>
          @titleRegion crew
          @formRegion crew

        @show @layout

    titleRegion: (crew) ->
      titleView = @getTitleView crew
      @layout.titleRegion.show titleView

    formRegion: (crew) ->
      editView = @getEditView crew

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "crew:cancelled", crew

      # Wrap editView in a form.
      formView = App.request "form:wrapper", editView,
        footer: true  # Controller overwrites view set config.

      @layout.formRegion.show formView

    getTitleView: (crew) ->
      new Edit.Title
        model: crew

    getLayoutView: (crew) ->
      new Edit.Layout
        model: crew

    getEditView: (crew) ->
      new Edit.Crew
        model: crew
