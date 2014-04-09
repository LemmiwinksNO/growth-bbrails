@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Application

    initialize: (options) ->
      # Sets id and member from options.id and options.member
      { id, member } = options

      # Use crew member model if we have it, else request it.
      # Need latter when user routes directly to edit.
      member or= App.request "crew:entity", id

      @listenTo member, "updated", ->
        App.vent.trigger "crew:member:updated", member

      # Don't load the edit page until crew member model is fetched.
      App.execute "when:fetched", member, =>
        @layout = @getLayoutView member

        @listenTo @layout, "show", =>
          @titleRegion member
          @formRegion member

        @show @layout

    titleRegion: (member) ->
      titleView = @getTitleView member
      @layout.titleRegion.show titleView

    formRegion: (member) ->
      editView = @getEditView member

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "crew:member:cancelled", member

      # Wrap editView in a form.
      formView = App.request "form:wrapper", editView,
        footer: true  # Controller overwrites view set config.

      @layout.formRegion.show formView

    getTitleView: (member) ->
      new Edit.Title
        model: member

    getLayoutView: (member) ->
      new Edit.Layout
        model: member

    getEditView: (member) ->
      new Edit.Crew
        model: member
