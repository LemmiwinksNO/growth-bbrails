@PlanetExpress.module "Views", (Views, App, Backbone, Marionette, $, _) ->

	_remove = Marionette.View::remove

	_.extend Marionette.View::,

		addOpacityWrapper: (init = true) ->
			@$el.toggleWrapper  # toggleWrapper is a jquery function we add
				className: "opacity"
			, init

		# Method that reduces noise in a view file by taking key value pairs
		# off of the @options object and setting them directly.
		# i.e. @config vs @options.config
		setInstancePropertiesFor: (args...) ->
			for key, val of _.pick(@options, args...)
				@[key] = val

		# Custom remove shows fancy red toggleWrapper if model is destroyed,
		# otherwise it jsut removes the view.
		remove: (args...) ->
			console.log "removing", @
			# If model is destroyed
			if @model?.isDestroyed()
				# wrap el in toggleWrapper like forms but with red background
				wrapper = @$el.toggleWrapper
					className: "opacity"
					backgroundColor: "red"
				# After 400ms, remove wrapper
				wrapper.fadeOut 400, ->
					$(@).remove()
				# Wire up view's el to remove itself after 400ms
				@$el.fadeOut 400, =>
					_remove.apply @, args
			else
				# Otherwise, just call remove on the view.
				_remove.apply @, args

		templateHelpers: ->

			linkTo: (name, url, options = {}) ->
				_.defaults options,
					external: false

				url = "#" + url unless options.external

				"<a href='#{url}'>#{@escape(name)}</a>"