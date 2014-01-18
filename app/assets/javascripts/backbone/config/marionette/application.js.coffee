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
    # TODO: User model/controller/view on backend, we send down all the user's
    # data at once. We have a User BB model, maybe we put all this logic there.
    # TODO: Is this the right place to do this?
    setUserData: ->
      @User = {}
      @User.focuses = @request "focus:entities"

      # Everything is included with focuses
      @execute "when:fetched", @User.focuses, =>

        # Get all projects and store in @User.projects
        @User.projects = @request "new:project:collection"  # Empty collection
        project_collections = @User.focuses.pluck('projects')  # Get array of projectCollections
        _.each project_collections, (project_collection) =>
          @User.projects.add project_collection.models

        # Get all procedures and store in @User.procedures
        @User.procedures = @request "new:procedure:collection"  # Empty collection
        procedure_collections = @User.focuses.pluck('procedures')  # Get array of procedureCollections
        _.each procedure_collections, (procedure_collection) =>
          @User.procedures.add procedure_collection.models

        # Get all tickets and store in @User.tickets
        @User.tickets = @request "new:ticket:collection"  # Empty collection
        ticket_collections = @User.projects.pluck('tickets') # Get array of ticketCollections
        _.each ticket_collections, (ticket_collection) =>
          @User.tickets.add ticket_collection.models