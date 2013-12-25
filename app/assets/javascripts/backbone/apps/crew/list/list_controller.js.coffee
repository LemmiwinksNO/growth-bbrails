
# <strong>Controllers</strong> <br>
# (1) Responsible for managing within a sub-module <br>
# (2) Instantiates and wires up views <br>
# (3) Manages entities <br>
# (4) responds to view events <br>
# (5) Bubbles up information to parent module <br>

@PlanetExpress.module "CrewApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      crew = App.request "crew:entities"

      # entities/_base/_fetch.js.coffee
      # Purpose: Waits until all models are fetched, then calls callback.
      App.execute "when:fetched", crew, =>

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @crewRegion crew

        # Custom controller show method - Shows @layout in mainRegion and
        # listens to its close event so we know to clean up this controller.
        #   @listenTo @layout, "close", @close.
        #   App.mainRegion.show @layout
        @show @layout

    onClose: ->
      console.info "closing controller!"

    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    panelRegion: ->
      panelView = @getPanelView()

      # When user clicks add in panelRegion, setup newRegion
      @listenTo panelView, "new:crew:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    # Setup newRegion. This is the new module's responsibility, so
    # let it handle this.
    newRegion: ->
      # region = @layout.newRegion
      # # This is how we communicate between controllers
      # newView = App.request "new:crew:member:view"

      # @listenTo newView, "form:cancel", =>
      #   region.close()

      # region.show newView

      # Let the new_controller handle this
      App.execute "new:crew:member", @layout.newRegion

    crewRegion: (crew) ->
      crewView = @getCrewView crew

      # When user clicks a crew member, go to edit page.
      @listenTo crewView, "childview:crew:member:clicked", (child, args) ->
        # Use vent when the current module doesn't need anything returned.
        App.vent.trigger "crew:member:clicked", args.model

      # args -> view instance, model, collection
      @listenTo crewView, "childview:crew:delete:click", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get("name")}?" then model.destroy() else false

      @layout.crewRegion.show crewView

    getCrewView: (crew) ->
      new List.Crew
        collection: crew
        options: "options"

    getLayoutView: ->
      new List.Layout

    getPanelView: ->
      new List.Panel

    getTitleView: ->
      new List.Title

