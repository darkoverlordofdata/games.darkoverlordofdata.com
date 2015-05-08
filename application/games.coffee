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

  ###
   * Set the Games routes
  ###
  server.route [
    {
      #
      # FaceBook iframe canvas
      #
      method: 'POST'
      path: '/game/{name}'
      config:
        handler: (request, reply) ->
          server.methods.find 'Game', slug:request.params.name, (err, game) ->
            reply.redirect game.url+'/'+game.main

    }
    {
      #
      # Run in iframe
      #
      method: 'GET' # Show in an iframe
      path: '/game/{name}'
      config:
        handler: (request, reply) ->
          server.methods.find 'Game', slug:request.params.name, (err, game) ->
            reply.view 'play_game', game: game

    }
    {
      #
      # NodeWebkit download??? Do we need this???
      #
      method: 'GET'
      path: '/nw/{name}'
      config:
        handler: (request, reply) ->
          zipdir path.join(server.settings.app.base, '/public/game/', request.params.name), (err, data) ->
            return reply(err) if err
            reply(data)
            .type('application/zip')
            .header('Content-Disposition', 'attachment; filename='+request.params.name+'.nw')
            .header('Content-Length', data.length)

        id: 'nw'
    }
  ]


  next()
  return

exports.register.attributes = name: 'games'
