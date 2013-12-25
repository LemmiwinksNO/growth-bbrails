# Purpose: Prevent page loads before entities finish fetching, which makes
# views show incorrectly, then jump.
#
# Custom sync method: Call regular sync method, then set the returned
# XHR object on the entity. (entity._fetch)

do (Backbone) ->

  _sync = Backbone.sync  # backup original sync method

  Backbone.sync = (method, entity, options = {}) ->

    _.defaults options,
      beforeSend: _.bind(methods.beforeSend, entity)
      complete:   _.bind(methods.complete,   entity)

    # Call backup sync whichs returns XHR object
    sync = _sync(method, entity, options)

    # If entity doesn't have _fetch property and method == 'read'
    # set _fetch to the XHR object.
    if !entity._fetch and method is "read"
      entity._fetch = sync

  methods =
    beforeSend: ->
      # fire this event before ajax call to server.
      @trigger "sync:start", @

    complete: ->
      @trigger "sync:stop", @