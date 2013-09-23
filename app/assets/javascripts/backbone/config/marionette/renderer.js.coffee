# do (Marionette) ->
# 	_.extend Marionette.Renderer,

#     root: "backbone/apps/"

#     render: (template, data) ->
#       path = @getTemplate(template)
#       throw "Template #{template} not found!" unless path
#       path(data)

#     # This makes it so we can write templates as header/list/header
#     # rather than header/list/templates/header.
# 		getTemplate: (template) ->
# 			for path in [template, template.split("/").insertAt(-1, "templates").join("/")]
# 				return JST[@root + path] if JST[@root + path]

do (Marionette) ->
  _.extend Marionette.Renderer,

    lookups: ["backbone/apps/", "backbone/components/"]

    render: (template, data) ->
      path = @getTemplate(template)
      throw "Template #{template} not found!" unless path
      path(data)

    # This makes it so we can write templates as header/list/header
    # rather than header/list/templates/header.
    getTemplate: (template) ->
      for path in [template, template.split("/").insertAt(-1, "templates").join("/")]
        for lookup in @lookups
          return JST[lookup + path] if JST[lookup + path]