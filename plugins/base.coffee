#
# Main routes:
#
#   /
#   /about
#   /terms
#   /privacy
#
exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')

  server.route [
    {
      method: 'GET'
      path: '/'
      config:
        id: 'index'
        handler: (request, reply) ->
          server.methods.findAll 'Katra', (err, katras) ->
            server.methods.findAll 'Game', (err, games) ->
              server.methods.liquid 'index',
                topHref: '/about'
                topButton: 'About'
                katras: katras
                games: games
              ,(err, result) ->
                reply(result)

    }
    {
      method: 'GET'
      path: '/about'
      config:
        id: 'about'
        handler: (request, reply) ->
          server.methods.liquid 'about',
            topHref: '/'
            topButton: 'Home'
          ,(err, result) ->
            reply(result)
    }
    {
      method: 'GET'
      path: '/terms'
      config:
        id: 'terms'
        handler: (request, reply) ->
          server.methods.liquid 'terms',
            topHref: '/'
            topButton: 'Home'
          ,(err, result) ->
            reply(result)
    }
    {
      method: 'GET'
      path: '/privacy'
      config:
        id: 'privacy'
        handler: (request, reply) ->
          server.methods.liquid 'privacy',
            topHref: '/'
            topButton: 'Home'
          ,(err, result) ->
            reply(result)
    }
  ]
  next()
  return

exports.register.attributes = name: 'base'
