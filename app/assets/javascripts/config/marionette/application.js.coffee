do (Backbone) ->

  _.extend Backbone.Marionette.Application::,

    # Get all user data and set it on the Application object
    setUser: ->
      user_id = @getUserID()
      @User = @request "user:entity", user_id

    # TODO: How do we handle User ID's? When do we set it?
    # Currently hard coded to return 1, since that is the only user.
    getUserID: ->
      return 1
