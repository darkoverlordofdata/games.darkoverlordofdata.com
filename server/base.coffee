# Base routes for default index/root path, about page, 404 error pages, and others..
exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')
  sqlite3 = require('sqlite3').verbose()

  db = new sqlite3.Database(path.resolve(__dirname, '../../db.sqlite3'))

  server.route [
    {
      method: "GET"
      path: "/about"
      config:
        handler: (request, reply) ->
          reply.view "about",
            topHref: '/home'
            topButton: 'Home'

          return

        id: "about"
    }
    {
      method: "GET"
      path: "/terms"
      config:
        handler: (request, reply) ->
          reply.view "terms",
            topHref: '/'
            topButton: 'Home'

          return

        id: "terms"
    }
    {
      method: "GET"
      path: "/privacy"
      config:
        handler: (request, reply) ->
          reply.view "privacy",
            topHref: '/'
            topButton: 'Home'

          return

        id: "privacy"
    }
    {
      method: "GET"
      path: "/"
      config:
        handler: (request, reply) ->
          db.all 'SELECT * FROM katra', (err, rows) ->
            reply.view "index",
              topHref: '/about'
              topButton: 'About'
            return

          return

        id: "index"
    }


    {
      method: "GET"
      path: "/{path*}"
      config:
        handler: (request, reply) ->
          reply.view("404",
            url: request.url
            topHref: '/'
            topButton: 'Home'
          ).code 404
          return

        id: "404"
    }
  ]
  next()
  return

exports.register.attributes = name: "base"
