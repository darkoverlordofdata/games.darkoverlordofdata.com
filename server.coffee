###*
Dependencies.
###
Hapi = require("hapi")
config = require('config-multipaas')()
console.log config

# Create a new server
server = new Hapi.Server()

# Setup the server with a host and port
server.connection
  port: config.get('PORT')
  host: config.get('IP')

#  port: parseInt(process.env.PORT, 10) or 8080
#  host: "0.0.0.0"


# Setup the views engine and folder
server.views
  path: "./server/views"
  engines:
    tpl: require('./server/liquid.coffee')


server.ext 'onPreResponse', (request, reply) ->
  response = request.response
  return reply.continue() if not response.isBoom
  reply.view '5xx',
    error: response.output.payload
    topHref: '/'
    topButton: 'Home'

# Export the server to be required elsewhere.
module.exports = server

#
#    Load all plugins and then start the server.
#    First: community/npm plugins are loaded
#    Second: project specific plugins are loaded
# 
server.register [
  {
    register: require("good")
    options:
      opsInterval: 5000
      reporters: [
        reporter: require("good-console")
        args: [
          ops: "*"
          request: "*"
          log: "*"
          response: "*"
          error: "*"
        ]
      ]
  }
  {
    register: require("hapi-assets")
    options:
      development: {
        js: ['js/test-one.js', 'js/test-two.js'],
        css: ['css/test-one.css', 'css/test-two.css']
      },
      production: {
        js: ['js/scripts.js'],
        css: ['css/styles.css']
      }
  }
  {
    register: require("hapi-named-routes")
  }
  {
    register: require("hapi-cache-buster")
  }
  {
    register: require("./server/assets")
  }
  {
    register: require("./server/base")
  }
  {
    register: require("./server/katra")
  }
  {
    register: require("./server/games")
  }
], ->
  
  #Start the server
  server.start ->
    
    #Log to the console the host and port info
    console.log "Server started at: " + server.info.uri
    return

  return

