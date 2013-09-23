# This Form submodule inputs a view and wraps it in a form.

@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends App.Controllers.Base

    initialize: (options = {}) ->
      @contentView = options.view

      @formLayout = @getFormLayout options.config

      @listenTo @formLayout, "show", @formContentRegion
      @listenTo @formLayout, "form:submit", @formSubmit
      @listenTo @formLayout, "form:cancel", @formCancel

    # Form cancel is use case specific, so we forward it to @contentView
    formCancel: ->
      @contentView.triggerMethod "form:cancel"

    formSubmit: ->
      data = Backbone.Syphon.serialize @formLayout
      # Ask view if it is ok to update the form. triggerMethod fires
      # form:submit event AND triggers onFormSubmit in the view if there
      # is one.
      if @contentView.triggerMethod("form:submit", data) isnt false
        model = @contentView.model
        @processFormSubmit data, model

    processFormSubmit: (data, model) ->
      model.save data  # Note this is our custom save method.

    onClose: ->
      console.log "onClose", @

    formContentRegion: ->
      # Need to set region for this controller b/c it isn't passed in.
      # This region is created by our form controller
      @region = @formLayout.formContentRegion
      @show @contentView

    getFormLayout: (options = {}) ->
      # _.result grabs all key-value pairs off our view object with a key of "form"
      # Set default config, but let view override it. Then give controller last say.
      config = @getDefaultConfig _.result(@contentView, "form")
      _.extend config, options  # options comes from requesting controller.

      buttons = @getButtons config.buttons

      new Form.FormWrapper
        config: config
        model: @contentView.model
        buttons: buttons

    getDefaultConfig: (config = {}) ->
      # _.defaults fills in undefined properties in the config object.
      # i.e. if footer is set in config, it won't be overwritten here.
      _.defaults config,
        footer: true  # show footer
        focusFirstInput: true
        errors: true  # show errors
        syncing: true # allow custom sync event stuff (sync:start, sync:stop)

    # Get buttons collection unless buttons is set to false in view.
    getButtons: (buttons = {}) ->
      App.request("form:button:entities", buttons, @contentView.model) unless buttons is false

  App.reqres.setHandler "form:wrapper", (contentView, options = {}) ->
    # Make sure contentview has a model.
    throw new Error "No model found inside of form's contentView" unless contentView.model

    formController = new Form.Controller
      view: contentView
      config: options

    formController.formLayout  # Return the layout