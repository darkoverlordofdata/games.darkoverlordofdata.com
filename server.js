var cc     = require('config-multipaas'),
    Hapi   = require('hapi'),
    path   = require('path')
var config = cc()


var server = new Hapi.Server()
server.connection({port: config.get('PORT'), host: config.get('IP')});

// Routes
server.route({
  method: 'GET',
  path: '/status', 
  handler: function (request, reply) { 
    reply( {"status": "ok"} )
  }
})
server.route({
  method: 'GET',
  path: '/{param*}',
  handler: { directory: { path: './static/' }} // relativeTo: '/static/'
})

server.start(function () {
  console.log('Server started at: ' + server.info.uri);
});
