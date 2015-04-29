fs = require("fs")
path = require("path")
Liquid = require("liquid.coffee")
config = require('../config')
cache = {}

Liquid.Template.fileSystem =
  root: config.views
  readTemplateFile: (view) ->
    filename = path.join(config.views, view)
    if cache[filename]? then cache[filename] else cache[filename]=fs.readFileSync(filename, "utf-8")

module.exports =
  compile: (template, options) ->
    t = Liquid.Template.parse(template)
    (context, options) ->
      t.render(context)
