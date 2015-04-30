#
# Games server
#
Hapi = require('hapi')

config = require('../config')

#cache =
#  engine: require('catbox-memcached')
#  location: 'localhost:11211'

module.exports = server = new Hapi.Server(app: config) #, cache: cache)

#
# Setup the server with a host and port
#
server.connection
  port: config.port
  host: config.host

#
# Set the default views engine and folder
#
server.views
  path: config.views
  engines:
    tpl: require('liquid.coffee').setPath(config.views)

#
# Load all plugins:
#
plugins = [{
    register: require('good')
    options:
      opsInterval: 5000
      reporters: [
        reporter: require('good-console')
        args: config.log
      ]
  },{
    register: require('./db')
    options: require('../models')
  },{
    register: require('./errors')
  }]
#
# Remaining plugins from ../config
#
for plugin in config.plugins
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

