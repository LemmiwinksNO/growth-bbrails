@PlanetExpress.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Base extends Marionette.Controller

    # Set region if there is one, saves us the trouble of writing it every time.
    constructor: (options = {}) ->
      @region = options.region or App.request "default:region"
      super options
      # Set a unique instance id
      @_instance_id = _.uniqueId("controller")
      App.execute "register:instance", @, @_instance_id

    close: (args...) ->
      delete @region  # Just a demonstration, no advantage to doing this.
      delete @options
      super args
      App.execute "unregister:instance", @, @_instance_id

    # Setup our controller to close WITH the topmost view, then go ahead
    # and attach that view to the region.
    # Replaces App.mainRegion.show @layout
    show: (view) ->
      @listenTo view, "close", @close
      @region.show view
