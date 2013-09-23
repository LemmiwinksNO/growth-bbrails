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

    modelEvents:
      "change:_errors"  : "changeErrors"
      "sync:start"      : "syncStart"
      "sync:stop"       : "syncStop"

    initialize: ->
      # Set properties off @options object directly on the view.
      # i.e. @options.config -> @config
      @setInstancePropertiesFor "config", "buttons"

    # Results of data serialization are passed to the template that is rendered.
    serializeData: ->
      footer: @config.footer
      # ? cs operator - if @options.buttons is null or undefined, stop. The second
      # ? sets the value if null or undefined.
      buttons: @buttons?.toJSON() ? false

    onShow: ->
      # Pushes this callback to the bottom of the callstack. We want this done last.
      # Only call this if set to true in config
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    focusFirstInput: ->
      # Find first input that is visible enabled and focus on it.
      @$(":input:visible:enabled:first").focus()

    # Determine data-type for style reasons.
    getFormDataType: ->
      if @model.isNew() then "new" else "edit"

    # When _errors property changes, call addErrors
    changeErrors: (model, errors, options) ->
      if @config.errors  # if errors is set to true
        # Did we unset or set _errors?
        if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    removeErrors: ->
      # Round up all the elements with .error class and remove it, then
      # find all the small elements within and remove them.
      @$(".error").removeClass("error").find("small").remove()

    # wrapper for addError
    addErrors: (errors = {}) ->
      for name, array of errors
        @addError name, array[0]  # Send first item in array

    addError: (name, error) ->
      el = @$("[name='#{name}']")
      sm = $("<small>").text(error)  # create jquery object and add error message
      # Set small error message after el, then add error class to nearest .row
      # closest tells jquery to traverse up the DOM until it finds .row
      el.after(sm).closest(".row").addClass("error")

    # Add opacity class on sync:start (visual loading cue)
    syncStart: (model) ->
      @addOpacityWrapper() if @config.syncing

    # Remove opacity class on sync:stop
    syncStop: (model) ->
      @addOpacityWrapper(false) if @config.syncing