# Sets @planetExpress = (function(Backbone, Marionette){})(Backbone, Marionette);
# Which is a self-invoking function. Why do we do this? So it gets called
# right away?
@PlanetExpress = do (Backbone, Marionette) ->

  App = new Marionette.Application

  # Fires before intializers kick off, you can pre-process some data
  # just before initialization happens.
  App.on "initialize:before", (options) ->
    # Recieves options passed to our App.start method (index.html.erb)
    App.environment = options.environment

  App.addRegions
    headerRegion: "#header-region"
    mainRegion:   "#main-region"
    footerRegion: "#footer-region"

  App.rootRoute = "/backlog"

  # Callbacks will be executed when app starts.
  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    @setUser()  # Get all the user's data and set it on App.User

  # Controller.constructor() sets @region. If one isn't passed in, we
  # request the default region.
  App.reqres.setHandler "default:region", ->
    App.mainRegion

  # Fires after initializers have finished.
  App.on "initialize:after", ->
    # Listen for URL fragment changes and trigger routing code in sub-apps, which
    # in turn executes the controller action in appropriate sub-app's action module
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  # Fires after all initializers and initializer events (before/after)
  # App.on "start", ->

  App
