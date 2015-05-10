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

#
# Create core system, injecting configuration and memory cache manager
#
module.exports = server = new Hapi.Server(app: require('../config'), cache: engine: require('catbox-memory'))

#
# Set host and port
#
server.connection
  port: server.settings.app.port
  host: server.settings.app.host

#
# Set the default views engine and folder
#
server.views
  path: server.settings.app.views
  defaultExtension: 'tpl'
  engines:
    tpl: require('liquid.coffee').setPath(server.settings.app.views)

#
# Load core plugins
#
plugins = [
  {     # logging
    register: require('good')
    options:
      opsInterval: server.settings.app.opsInterval
      reporters: [
        reporter: require('good-console')
        args: server.settings.app.log
      ]
  }, {  # custom cache
    register: require('./cache/memjs')
  }, {  # database
    register: require('./db/firebase')
  }, {  # error handler
    register: require('./errors')
  }, {  # session manager
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

