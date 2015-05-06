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
        plugins: 'hapi-auth-cookie': redirectTo: false
        id: 'index'
        handler: (request, reply) ->
          server.methods.findAll 'Katra', (err, katras) ->
            server.methods.findAll 'Game', (err, games) ->
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

exports.register.attributes = name: 'base'
