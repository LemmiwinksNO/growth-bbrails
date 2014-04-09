# This is for debugging purposes. The registry keeps track of all our
# open controllers. This is helpful b/c it's easy to forget to close
# down a controller.
@PlanetExpress.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  API =

    register: (instance, id) ->
      # If @_registry is set to null or undefined, set it to {}
      @_registry ?= {}
      @_registry[id] = instance

    unregister: (instance, id) ->
      delete @_registry[id]

    # Close out all our controllers. Warns you if some controllers don't shut down.
    # Great tool for unit testing -> toss it in an afterTest hook
    resetRegistry: ->
      oldCount = @getRegistrySize()
      # of -> only iterates on hasOwnProperties
      for key, controller of @_registry
        controller.region.close()
      msg = "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"

    getRegistrySize: ->
      # _.size counts keys in our object like it was an array
      _.size @_registry


  # Set/unset controller ids to App._registry for debugging purposes.
  # We can use this to make sure controllers get closed.
  App.commands.setHandler "register:instance", (instance, id) ->
    API.register instance, id if App.environment is "development" or "test"

  App.commands.setHandler "unregister:instance", (instance, id) ->
    API.unregister instance, id if App.environemnt is "development" or "test"

  App.reqres.setHandler "reset:registry", ->
    API.resetRegistry()

  App.reqres.setHandler "get:registry_size", ->
    API.getRegistrySize()