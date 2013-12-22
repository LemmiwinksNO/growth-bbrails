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

    # Custom show method which shows the view(i.e. @layout) and attaches
    # a listener to its close event so we clean up this controller when
    # the view closes.
    # Replaces:
    #   @listenTo @layout, "close", @close
    #   App.mainRegion.show @layout
    show: (view) ->
      @listenTo view, "close", @close
      @region.show view
