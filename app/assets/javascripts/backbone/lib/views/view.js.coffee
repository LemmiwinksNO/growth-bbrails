@PlanetExpress.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  _remove = Marionette.View::remove

  _.extend Marionette.View::,

    addOpacityWrapper: (init = true) ->
      @$el.toggleWrapper  # jQuery function we added
        className: 'opacity'
      , init

    # Method that reduces noise in a view file by taking key-value pairs
    # off of the @options object and setting them directly.
    # i.e. @config vs @options.config
    setInstancePropertiesFor: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val

    # Custom remove shows fancy red toggleWrapper if model is destroyed
    # otherwise it just removes the view.
    remove: (args...) ->
      # If model is destroyed
      # NOTE: Added check for isDestroyed function b/c my empty views have an empty
      # model for some reason.
      if @model?.isDestroyed?()  # confirm we have a model and isDestroyed() == function
        # wrap el in toggleWrapper like forms but with red background
        wrapper = @$el.toggleWrapper
          className: 'opacity'
          backgroundColor: 'red'

        wrapper.fadeOut 400, ->
          $(@).remove()

        @$el.fadeOut 400, =>
          _remove.apply @, args
      else
        # otherwise, just remove the view.
        _remove.apply @, args

    templateHelpers: ->

      linkTo: (name, url, options = {}) ->
        _.defaults options,
          external: false

        url = "#" + url unless options.external

        "<a href='#{url}'>#{@escape(name)}</a>"