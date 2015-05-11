###
 * Basic routes
###
##
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
      path: '/stats'
      config:
        id: 'stats'
        handler: (request, reply) ->
          server.methods.cache.stats (err, server, stats) ->
            console.log err
            console.log server
            console.log stats
            reply.redirect '/'

    }
    {
      method: 'GET'
      path: '/'
      config:
        id: 'index'
        handler: (request, reply) ->
          server.methods.findAll 'Katra', (err, katras) ->
            server.methods.findAll 'Game', (err, games) ->
#              data =
#                topHref: '/about'
#                topButton: 'About'
#                katras: katras
#                games: games
#
#              server.render 'index', data, {}, (err, rendered, config) ->
#                console.log  'render '+rendered.length+' bytes'
#
#
              reply.view 'index',
                topHref: '/about'
                topButton: 'About'
                katras: katras
                games: games


    }
    {
      method: 'GET'
      path: '/about'
      config:
        id: 'about'
        handler:
          view:
            template: 'about'
            context:
              topHref: '/'
              topButton: 'Home'


    }
    {
      method: 'GET'
      path: '/terms'
      config:
        id: 'terms'
        handler:
          view:
            template: 'terms'
            context:
              topHref: '/'
              topButton: 'Home'

    }
    {
      method: 'GET'
      path: '/privacy'
      config:
        id: 'privacy'
        handler:
          view:
            template: 'privacy'
            context:
              topHref: '/'
              topButton: 'Home'

    }

    {
      method: ['GET','POST']
      path: '/katra'
      config:
        handler:
          view: template: 'katra'

    }
  ]
  next()
  return

exports.register.attributes = name: 'default'
