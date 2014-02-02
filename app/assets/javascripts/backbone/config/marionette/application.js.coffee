do (Backbone) ->

  _.extend Backbone.Marionette.Application::,

    navigate: (route, options = {}) ->
      # route = "+" + route if route.charAt(0) is "/"
      Backbone.history.navigate route, options

    getCurrentRoute: ->
      frag = Backbone.history.fragment
      if _.isEmpty(frag) then null else frag

    startHistory: ->
      if Backbone.history
        Backbone.history.start()

    # Registry stuff is for debugging purposes. It keeps track of all our
    # open controllers. This is helpful b/c it's easy to forget to close
    # down a controller.
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
      msg = "There were #{oldCount} controllers in the registry, there are not #{@getRegistrySize()}"

    getRegistrySize: ->
      # _.size counts keys in our object like it was an array
      _.size @_registry

    # Get all user data and set it on the Application object
    setUser: ->
      user_id = @getUserID()
      @User = @request "user:entity", user_id

    # TODO: How do we handle User ID's? When do we set it?
    # Currently hard coded to return 1, since that is the only user.
    getUserID: ->
      return 1
