fs = require("fs")
path = require("path")
Liquid = require("liquid.coffee")
cache = {}

Liquid.Template.fileSystem =
  root: path.resolve(__dirname, "./views")
  readTemplateFile: (view) ->
    filename = path.join(__dirname, "./views", view)
    if cache[filename]? then cache[filename] else cache[filename]=fs.readFileSync(filename, "utf-8")

module.exports =
  compile: (template, options) ->
    t = Liquid.Template.parse(template)
    (context, options) ->
      t.render(context)
