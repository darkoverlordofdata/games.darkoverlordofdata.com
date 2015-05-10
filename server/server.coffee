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

memcachier = if process.env.memcachier_29492? then JSON.parse(process.env.memcachier_29492)
if memcachier?
  memcachier = memcachier.username+':'+memcachier.password+'@'+memcachier.servers
else
  memcachier = 'localhost:11211'

memcached = if process.env.memcachedcloud_aaaeb? then JSON.parse(process.env.memcachedcloud_aaaeb)
if memcached?
  memcached = memcached.username+':'+memcached.password+'@'+memcached.servers
else
  memcached = 'localhost:11211'

console.log 'WARNING: memcachier on '+memcachier
console.log 'WARNING: memcached on '+memcached


cacheOptions = [
  {
    engine: require('catbox-memory')
  }
#  {
#    name: 'memcached'
#    engine: require('catbox-memcached')
#    location: memcached
#  }
#  {
#    name: 'memcachier'
#    engine: require('catbox-memcachier')
#    location: memcachier+'1'
#  }
]


#
# Create core system, injecting configuration and memory cache manager
#
module.exports = server = new Hapi.Server(app: require('../config/config'), cache: cacheOptions)

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
#plugins = ({register: require(plugin), options: options} for plugin, options of require('../config/plugins'))

plugins = []
for plugin, options of require('../config/plugins')
  console.log 'install plugin: '+plugin
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

