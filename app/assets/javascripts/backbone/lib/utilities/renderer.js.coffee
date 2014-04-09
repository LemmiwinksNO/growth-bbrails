@PlanetExpress.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  _.extend Marionette.Renderer,

    lookups: ["backbone/apps/", "backbone/lib/components/"]

    render: (template, data) ->
      path = @getTemplate(template)
      throw "Template #{template} not found!" unless path
      path(data)

    # This makes it so we can write templates as header/list/header
    # rather than header/list/templates/header.
    getTemplate: (template) ->
      for lookup in @lookups
        ## inserts the template at the '-1' position of the template array
        ## this allows us to omit the word 'templates' from the view but
        ## still store the templates in a directory outside of the view.
        ## example: "users/list/layout" will become "users/list/templates/layout"

        for path in [template, @withTemplate(template)]
          return JST[lookup + path] if JST[lookup + path]

    withTemplate: (string) ->
      array = string.split("/")
      array.splice(-1, 0, "templates")
      array.join("/")