exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')
  Liquid = require("liquid.coffee")

  cache0 = {} # file content cache0
  cache1 = {} # compiled template cache1

  #
  # Liquid file system hook
  #
  Liquid.Template.fileSystem =
    root: server.settings.app.views
    readTemplateFile: (view) ->
      filename = path.join(server.settings.app.views, view)
      if cache0[filename]? then cache0[filename] else cache0[filename]=fs.readFileSync(filename, "utf-8")


  server.method

    name: 'liquid'
    #
    # Register as a cacheable server method
    #
    options:
      cache: expiresIn: 60000
      generateKey: (view, data) -> view+JSON.stringify(data)
    #
    # Liquid template rendering
    #
    method: (view, data, next) ->
      filename = path.join(server.settings.app.views, view+'.tpl')
      template = if cache0[filename]? then cache0[filename] else cache0[filename]=fs.readFileSync(filename, "utf-8")
      t = if cache1[filename]? then cache1[filename] else cache1[filename]=Liquid.Template.parse(template)
      next(null, t.render(data))



  next()
  return

exports.register.attributes = name: "liquid"
