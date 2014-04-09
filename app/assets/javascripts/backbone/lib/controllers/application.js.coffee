@PlanetExpress.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Application extends Marionette.Controller

    # Set region if there is one, saves us the trouble of writing it every time.
    constructor: (options = {}) ->
      @region = options.region or App.request "default:region"
      super options
      # Set a unique instance id
      @_instance_id = _.uniqueId("controller")
      App.execute "register:instance", @, @_instance_id

    close: () ->
      console.log "closing", @
      App.execute "unregister:instance", @, @_instance_id
      super # When nothing is passed to it, it uses arguments

    # Custom show method which shows the view(i.e. @layout) and attaches
    # a listener to its close event so we clean up this controller when
    # the view closes.
    # Replaces:
    #   @listenTo @layout, "close", @close
    #   App.mainRegion.show @layout
    show: (view) ->
      @listenTo view, "close", @close
      @region.show view
