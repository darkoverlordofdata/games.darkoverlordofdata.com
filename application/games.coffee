#
# Run or download from the game public folder
#
# game routes:
#
#   /{game}
#   /ns/{game}
#
exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')
  zipdir = require('zip-dir')

  server.route [
    {
      method: ["GET", "POST"] # fb compatible
      path: "/game/{name}"
      config:
        handler: (request, reply) ->
#          reply.redirect request.params.name+'/'+request.params.name+'.html'
          reply.redirect 'https://darkoverlordofdata.com/'+request.params.name+'/'+request.params.name+'.html'
          return

    }
    {
      method: "GET"
      path: "/nw/{name}"
      config:
        handler: (request, reply) ->
          zipdir path.join(server.settings.app.base, '/public/game/', request.params.name), (err, data) ->
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
