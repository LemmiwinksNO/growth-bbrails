@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"

    # Out custom save method waits for server reponse before updating
    # model attributes.
    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true  # We want to wait for server response by default.
        # Use bind when you want to call something later.
        # _.bind takes method, context, arguments
        success: _.bind(@saveSuccess, @, isNew, options.collection)
        error:   _.bind(@saveError, @)

      @unset "_errors"  # unset each save so errors don't linger
      super data, options  # Call Backbone.model.save

    # Point here is to create specific events we can bind to with our views/controllers.
    # 'Created' and 'updated' are more explicit than 'sync.'
    # We also add/update the model to the relevant collection right away
    # and fire specific events we can hook into.
    saveSuccess: (isNew, collection) =>
      if isNew  ## model is being created
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        @trigger "created", @
      else      ## model is being updated
        collection ?= @collection
        collection.trigger "model:updated", @ if collection
        @trigger "updated", @

    # set errors directly on the model unless status returned was 500 or 404.
    # $.parseJSON turns json into a valid JS object.
    # Errors are stored in xhr object's errors property.
    saveError: (model, xhr, options) =>
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless xhr.status is 500 or xhr.status is 404