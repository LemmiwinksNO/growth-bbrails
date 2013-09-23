@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  # Wait until all models are fetched, then call callback.
  # i.e. don't load the page until we have the models.
  App.commands.setHandler "when:fetched", (entities, callback) ->
    # Flatten ensures we can handle an object or an array.
    # Then pluck the _fetch property from each object and return
    # an array of _fetch values.
    # We want an array of xhrs objects
    xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

    # xhrs = []
    # if _.isArray(entities)
    #   xhrs.push(entity._fetch) for entity in entities
    # else
    #   xhrs.push(entities._fetch)

    # ...(splat) passes in each object in array to when
    $.when(xhrs...).done ->
      callback()