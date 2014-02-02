
@PlanetExpress = do (Backbone, Marionette) ->

  App = new Marionette.Application

  # Recieves options passed to our App.start method (index.html.erb)
  App.on "initialize:before", (options) ->
    App.environment = options.environment

  App.addRegions
    headerRegion: "#header-region"
    mainRegion:   "#main-region"
    footerRegion: "#footer-region"

  App.rootRoute = "/backlog"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    @setUser()  # Get all the user's data and set it on App.User

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  # Set/unset controller ids to App._registry for debugging purposes.
  # We can use this to make sure controllers get closed.
  App.commands.setHandler "register:instance", (instance, id) ->
    App.register instance, id if App.environment is "development" or "test"

  App.commands.setHandler "unregister:instance", (instance, id) ->
    App.unregister instance, id if App.environemnt is "development" or "test"

  App.on "initialize:after", ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
