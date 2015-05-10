###

    _____                   ____      ___
   / ___/__ ___ _  ___ ____/ __ \____/ _ \___ ___ _  ___ _
  / (_ / _ `/  ' \/ -_)___/ /_/ /___/ , _/ _ `/  ' \/ _ `/
  \___/\_,_/_/_/_/\__/    \____/   /_/|_|\_,_/_/_/_/\_,_/

###
##
#
#
# Create core system, injecting configuration and cache manager
#
Hapi = require('hapi')
module.exports = server = new Hapi.Server(app: require('../config'), cache: require('./cache'))

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
# Load plugins
##
plugins = []
for plugin, options of require('../config/plugins')
  console.log 'plugin: '+plugin
  plugins.push
    register: require(plugin)
    options: options


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

