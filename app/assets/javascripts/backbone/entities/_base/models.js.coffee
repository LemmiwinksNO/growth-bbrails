@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"

    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true  # We want to wait for server response by default.
        # User bind when you want to call something later.
        # _.bind takes method, context, arguments
        success: _.bind(@saveSuccess, @, isNew, options.collection)
        error:   _.bind(@saveError, @)

      @unset "_errors"  # because we don't want this property hanging around
      super data, options  # Call Backbone.model.save

    # Point here is to create specific events we can bind to. Rather than bind to
    # sync event, we can bind to created or updated events.
    # We also add/update the model to relevant collection and fire specific events
    # we can hook into via our views and controllers.
    saveSuccess: (isNew, collection) =>
      if isNew ## model is being created
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        @trigger "created", @
      else ## model is being updated
        # if model has collection property defined, use that if no collection option exists.
        collection ?= @collection
        collection.trigger "model:updated", @ if collection
        @trigger "updated", @

    saveError: (model, xhr, options) =>
      # set errors directly on the model unless status returned was 500 or 404.
      # $.parseJSON turns json into a valid JS object.
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless xhr.status is 500 or xhr.status is 404