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
  sqlite3 = require('sqlite3').verbose()

  katra = []
  games = []

#  db = new sqlite3.Database(path.resolve(__dirname, '../db.sqlite3'))
#  db.all 'SELECT * FROM katra', (err, rows) -> katra = rows
#  db.all 'SELECT * FROM game', (err, rows) -> games = rows

  katra = require('./katra-data')
  games = require('./games-data')

  server.route [
    {
      method: "GET"
      path: "/"
      config:
        id: 'index'
        handler: (request, reply) ->
          server.methods.liquid 'index',
            topHref: '/about'
            topButton: 'About'
            katra: katra
            games: games
          ,(err, result) ->
            reply(result)

    }
    {
      method: "GET"
      path: "/about"
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
      method: "GET"
      path: "/terms"
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
      method: "GET"
      path: "/privacy"
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

exports.register.attributes = name: "base"
