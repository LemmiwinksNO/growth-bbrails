# This Form submodule inputs a view and wraps it in a form.
# Episode 7 part 2, 10 minutes

@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends App.Controllers.Base

    initialize: (options = {}) ->
      @contentView = options.view

      @formLayout = @getFormLayout options.config

      @listenTo @formLayout, "show", @formContentRegion
      @listenTo @formLayout, "form:submit", @formSubmit
      @listenTo @formLayout, "form:cancel", @formCancel
      @listenTo @formLayout, "form:remove", @formRemove

    # Delete the model and return to root page
    # NOTE: We listen to the model's destroy event in edit_controller
    formRemove: ->
      model = @contentView.model
      if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy()

    # Form cancel is use case specific, so we forward it to @contentView
    formCancel: ->
      # Pick this up in contentView with onFormCancel.
      # Or listen for it in contentView's controller.
      @contentView.triggerMethod "form:cancel"

    # Get our form data using syphon (creates object using 'name' as key)
    # Give our contentView a chance to prevent submitting the form, would be in
    # its onFormSubmit method. (called automatically when triggering 'form:submit')
    formSubmit: ->
      data = Backbone.Syphon.serialize @formLayout
      if @contentView.triggerMethod("form:submit", data) isnt false
        model = @contentView.model
        @processFormSubmit data, model

    # Save the model using our custom backbone save method.
    processFormSubmit: (data, model) ->
      model.save data

    # Called automatically when this controller closes.
    # onClose: ->
      # console.log "onClose", @

    # Need to set region for this controller b/c it wasn't passed in.
    formContentRegion: ->
      @region = @formLayout.formContentRegion
      @show @contentView # @formLayout.formContentRegion.show @contentView

    getFormLayout: (options = {}) ->
      # _.result grabs all key-value pairs off our view object with a key of "form"
      # Set default config, but let view override it. Then give controller last say.
      config = @getDefaultConfig _.result(@contentView, "form")
      _.extend config, options  # overwrite default config with controller set options

      buttons = @getButtons config.buttons

      new Form.FormWrapper
        config: config
        model: @contentView.model
        buttons: buttons

    # _.defaults fills in undefined properties in the config object.
    # i.e. if footer is set in config, it won't be overwritten here.
    getDefaultConfig: (config = {}) ->
      _.defaults config,
        footer: true   # show footer
        focusFirstInput: true  # focus first input
        errors: true   # show errors
        syncing: true  # allow custom sync event stuff (sync:start, sync:stop)

    # Get buttons collection unless buttons is set to false in view.
    getButtons: (buttons = {}) ->
      App.request("form:button:entities", buttons, @contentView.model) unless buttons is false

  App.reqres.setHandler "form:wrapper", (contentView, options = {}) ->
    throw new Error "No model found inside of form's contentView" unless contentView.model

    formController = new Form.Controller
      view: contentView
      config: options

    formController.formLayout  # Return the layout