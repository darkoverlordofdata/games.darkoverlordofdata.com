#
# Games server
#
Hapi = require('hapi')

module.exports = server = new Hapi.Server(app: require('../config')) #, cache: require('./cache'))

#
# Setup the server with a host and port
#
server.connection
  port: server.settings.app.port
  host: server.settings.app.host

#
# Set the default views engine and folder
#
server.views
  path: server.settings.app.views
  engines:
    tpl: require('liquid.coffee').setPath(server.settings.app.views)

#
# Load all plugins:
#
plugins = [{
    register: require('good')
    options:
      opsInterval: 5000
      reporters: [
        reporter: require('good-console')
        args: server.settings.app.log
      ]
  },{
    register: require('./db')
    options: require('../db/models')
  },{
    register: require('./errors')
  }]
#
# Remaining plugins from ../config
#
for plugin in server.settings.app.plugins
  console.log 'plugin: '+plugin
  plugins.push register: require(plugin)

#
# Register plugins and start the server
#
server.register plugins, ->
  server.start ->
    #
    # Log to the console the host and port info
    #
    console.log 'Game*O*Rama'
    console.log 'Server started at: ' + server.info.uri

