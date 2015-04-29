#
# Games server
#
Hapi = require('hapi')
module.exports = server = new Hapi.Server(app:require('./config'))

#
# Setup the server with a host and port
#
server.connection
  port: server.settings.app.port
  host: server.settings.app.host


# Set the default views engine and folder
# This will be used to display 404 and 5xx error pages
views =
  path: server.settings.app.views
  engines: {}
views.engines[server.settings.app.view_ext] = require(server.settings.app.view_engine)
server.views views
#

plugins = []
#
# Load all plugins:
#
plugins.push
  register: require('good')
  options:
    opsInterval: 5000
    reporters: [
      reporter: require('good-console')
      args: server.settings.app.log
    ]

#
# Database connection
#
plugins.push
  register: require('./db')
  options: require('../models')

# Remaining plugins don't require options
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

