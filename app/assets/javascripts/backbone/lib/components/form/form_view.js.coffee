@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormWrapper extends App.Views.Layout
    template: "form/form"

    tagName: "form"
    attributes: ->
      "data-type": @getFormDataType()

    regions:
      formContentRegion: "#form-content-region"

    ui:
      buttonContainer: "ul.inline-list"

    # triggers automatically stopPropogation and preventDefault
    # Our controller listens for these events.
    triggers:
      "submit"                            : "form:submit"
      "click [data-form-button='cancel']" : "form:cancel"
      "click [data-form-button='remove']" : "form:remove"

    modelEvents:
      "change:_errors"  : "changeErrors"  # Set via custom save method
      "sync:start"      : "syncStart"     # Custom sync event
      "sync:stop"       : "syncStop"      # Custom sync event

    # Set properties off @options object directly on the view.
    # i.e. @config = @options.config
    initialize: ->
      @setInstancePropertiesFor "config", "buttons"

    # Results of data serialization are passed to the template that is rendered.
    # Serialize models/collections by calling toJSON on them.
    serializeData: ->
      footer: @config.footer
      buttons: @buttons?.toJSON() ? false

    # _defer pushes this callback to the bottom of the callstack. We want
    # this done last. Only call functions if set to true in config
    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    # Form can close BEFORE sync:stop event, which we use as a trigger
    # to remove the opacity wrapper. Make sure it gets closed.
    onClose: ->
      @syncStop() if @config.syncing

    # Focus on first input that is visible and enabled
    focusFirstInput: ->
      @$(":input:visible:enabled:first").focus()

    # Add left/right placement
    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    # Determine data-type for style reasons.
    getFormDataType: ->
      if @model.isNew() then "new" else "edit"

    # model's _errors property has changed.
    # Check if config is set to check errors (default)
    # Add or remove errors in the DOM
    changeErrors: (model, errors, options) ->
        if @config.errors
          if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    # Find all elements with .error and remove the class, then find all
    # "small" and remove them.
    removeErrors: ->
      @$(".error").removeClass("error").find("small").remove()

    # wrapper for addError
    # key = name, value = array of errors
    # Only send the first error
    addErrors: (errors = {}) ->
      for name, array of errors
        @addError name, array[0]

    # Find element with error using name.
    # Create jquery object and add error message
    # Set error message after el, then add error class to nearest .row up the DOM
    addError: (name, error) ->
      el = @$("[name='#{name}']")
      sm = $("<small>").text(error)
      el.after(sm).closest(".row").addClass("error")

    # Add opacity class on sync:start (visual loading cue)
    syncStart: (model) ->
      @addOpacityWrapper() if @config.syncing

    # Remove opacity class on sync:stop
    syncStop: (model) ->
      @addOpacityWrapper(false) if @config.syncing