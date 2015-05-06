#
# fb routes:
#
#
#FB = require('fb')
Purest = require('purest')
facebook = new Purest(provider:'facebook')

http = require('request')

exports.register = (server, options, next) ->

  fs = require('fs')
  path = require('path')

  ###
   * Callback to receive facebook logon
  ###
  server.route
    method: 'GET'
    path: '/login/callback' # .facebook.response.access_token
    handler: (request, reply) ->
      grant = request.session.get('grant')

      # loged in to facebook
      facebook.query()
      .get('me')
      .auth(grant.response.access_token)
      .request (err, res, user) ->
        throw new Error(err) if err

        # User data
        root = 'https://darkoverlordofdata.firebaseio.com/facebook/'
        http root+user.id+'.json?'+process.env.FIREBASE_AUTH, (err, res, games) ->
          throw new Error(err) if err

          # Games data
          # {"887669707958104":{"p1":42,"p2":42,"p3":42}}
          reply.view 'scores',
            user: user
            games: games


  server.route
    method: 'GET'
    path: '/leader'
    handler: (request, reply) ->
      db = request.server.plugins['hapi-mongodb'].db
      where =
        user: '816144091800924'
        app: '887669707958104'

      db.collection('scores').findOne where, (err, doc) ->
        if err
          reply(Hapi.error.internal('Internal MongoDB error', err))
        else
          reply(doc)



  server.route
    method: 'GET'
    path: '/score/{value}'
    handler: (request, reply) ->
      db = request.server.plugins['hapi-mongodb'].db

      where =
        user: '816144091800924'
        app: '887669707958104'

      data =
        user: '816144091800924'
        app: '887669707958104'
        scores: [42, 43, 42]

      db.collection('scores').update where, data, upsert: true, (err, doc) ->
        if err
          reply(Hapi.error.internal('Internal MongoDB error', err))
        else
          reply(doc)

  next()
  return

exports.register.attributes = name: 'fb'
