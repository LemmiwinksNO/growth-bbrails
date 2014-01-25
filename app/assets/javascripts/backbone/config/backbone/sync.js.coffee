# Purpose: Prevent page loads before entities finish fetching, which makes
# views show incorrectly, then jump.
#
# Custom sync method: Call regular sync method, then set the returned
# XHR object on the entity. (entity._fetch)
# Custom events: added sync:start and sync:stop, which we use for adding
# visual cues, i.e. fade form out when user hits submit.
# NOTE: sync:start and sync:stop stuff is a bit tricky. i.e. our form CLOSES out
# before it gets sync:stop trigger sometimes, meaning the opacity wrapper isn't
# closed out.

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
    # fired before ajax call to server.
    beforeSend: ->
      @trigger "sync:start", @

    # fired after ajax call
    complete: ->
      @trigger "sync:stop", @