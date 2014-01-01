@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Button extends Entities.Model
    defaults:
      buttonType: "button"

  class Entities.ButtonsCollection extends Entities.Collection
    model: Entities.Button

  API =

    # Get default button configuration.
    # Add buttons to array based on configuration.
    # Reverse array if buttons are placed on the left (submit left, cancel right)
    # Create a backbone collection, passing in our array of buttons.
    # Set placement property on collection so we can access it later.
    getFormButtons: (buttons, model) ->
      buttons = @getDefaultButtons buttons, model

      array = []
      array.push {
        type: "cancel",
        className: "button tiny secondary radius",
        text: buttons.cancel
      } unless buttons.cancel is false
      array.push {
        type: "remove",
        className: "button tiny alert radius",
        text: buttons.remove
      } unless buttons.remove is false
      array.push {
        type: "primary",
        className: "button tiny radius",
        text: buttons.primary
        buttonType: "submit"
      } unless buttons.primary is false

      array.reverse() if buttons.placement is "left"

      buttonCollection = new Entities.ButtonsCollection array
      buttonCollection.placement = buttons.placement
      buttonCollection

    getDefaultButtons: (buttons, model) ->
      _.defaults buttons,
        primary: if model.isNew() then "Create" else "Update"
        cancel: "Cancel"
        remove: if model.isNew() then false else "Remove"
        placement: "right"

  App.reqres.setHandler "form:button:entities", (buttons = {}, model) ->
    API.getFormButtons buttons, model