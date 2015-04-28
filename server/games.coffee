# Base routes for default index/root path, about page, 404 error pages, and others..
exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')
  zipdir = require('zip-dir')

  server.route [
    {
      method: ["GET", "POST"]
      path: "/game/{name}"
      config:
        handler: (request, reply) ->
          reply.redirect request.params.name+'/'+request.params.name+'.html'
          return

#        id: "game"
    }
    {
      method: "GET"
      path: "/nw/{name}"
      config:
        handler: (request, reply) ->
          zipdir path.join(__dirname, '../public/game/', request.params.name), (err, data) ->
            return reply(err) if err
            reply(data)
            .type('application/zip')
            .header('Content-Disposition', 'attachment; filename='+request.params.name+'.nw')
            .header('Content-Length', data.length)
            return

        id: "nw"
    }
  ]
  next()
  return

exports.register.attributes = name: "games"
