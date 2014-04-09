
# Purpose: Prevent page from rendering before entities finish fetching,
# which prevents views from showing incorrectly, then jumping.
#
# Episode 7, part 1, 56 min

@PlanetExpress.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  # Wait until all models are fetched, then call callback.
  # i.e. don't load the page until we have the models.
  App.commands.setHandler "when:fetched", (entities, callback) ->
    # For each entity in the array(or object), extract its _fetch property
    # and push it into our own array(xhrs[]). The _fetch property IS the
    # XHR event. We attach it via our custom backbone sync event.
    #
    # _.chain lets us use several _ methods on an object. Here we put
    # entities in an array, then flatten it to ensure that we have an array
    # no matter if we were passed an array or an object. Then we pluck _fetch
    # property from each element in the array and return its value.
    xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

    # xhrs = []
    # if _.isArray(entities)
        # For each entity in array, lets extract its _fetch property and
        # push it into our own array. Each _fetch property IS the XHR
        # event.
    #   xhrs.push(entity._fetch) for entity in entities
    # else  # object
    #   xhrs.push(entities._fetch)


    # xhrs is an array of XHR events (each _fetch property is an XHR
    # event). Each XHR event has jquery deferreds baked right in.
    # When each of those deferreds is resolved and are done, run callback.
    # ...(splat) passes in each object in array as a separate argument to when
    $.when(xhrs...).done ->
      callback()

