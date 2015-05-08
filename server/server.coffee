###

    _____                   ____      ___
   / ___/__ ___ _  ___ ____/ __ \____/ _ \___ ___ _  ___ _
  / (_ / _ `/  ' \/ -_)___/ /_/ /___/ , _/ _ `/  ' \/ _ `/
  \___/\_,_/_/_/_/\__/    \____/   /_/|_|\_,_/_/_/_/\_,_/



###
##
#
#
#
Hapi = require('hapi')

module.exports = server = new Hapi.Server(app: require('../config')) #, cache: require('./lib/cache'))

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
# Standard plugins:
#
#   logging
#   database
#   error handling
#   sessions
#
plugins = [{
    register: require('good')
    options:
      opsInterval: server.settings.app.opsInterval
      reporters: [
        reporter: require('good-console')
        args: server.settings.app.log
      ]
  }, {
    register: require('./db')
  }, {
    register: require('./errors')
  }, {
    register: require('yar')
    options: server.settings.app.yar
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
    console.log 'Started at: ' + server.info.uri

