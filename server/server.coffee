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

#
# Set the views engine and folder
#
server.views do ->
  views =
    path: server.settings.app.views
    engines: {}
  views.engines[server.settings.app.view_ext] = require(server.settings.app.view_engine)
  return views


#
# Load all plugins:
# First: check if logging is specified
#
plugins = if server.settings.app.log?
  [
    {
      register: require('good')
      options:
        opsInterval: 5000
        reporters: [
          reporter: require('good-console')
          args: server.settings.app.log
        ]
    }
  ]
else []

#
# Second: check if there are managed assets
#
if server.settings.app.assets?
  plugins.push
    register: require('hapi-assets')
    options: server.settings.app.assets

#
# Third: remaining plugins don't require options
#
for plugin in server.settings.app.plugins
  console.log 'plugin: '+plugin
  plugins.push register: require(plugin)

#
# Register plugins and start the server
#
server.register plugins, ->
  #
  # Start the server
  #
  server.start ->

    #
    # End of the line - Display a 404 error
    #
    server.route [
      {
        method: '*'
        path: '/{path*}'
        config:
          handler: (request, reply) ->
            reply.view('404', url: request.url).code(404)

      }
    ]

    #
    # Check for internal errors - Display 5xx errors
    #
    server.ext 'onPreResponse', (request, reply) ->
      response = request.response
      return reply.continue() if not response.isBoom
      reply.view('5xx', message: response.message, error: response.output.payload).code(500)

    #
    # Log to the console the host and port info
    #

    console.log 'Game*O*Rama'
    console.log 'Server started at: ' + server.info.uri
    return
  return

