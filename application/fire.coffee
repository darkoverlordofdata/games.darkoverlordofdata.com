#
# scores routes:
#
#
#FB = require('fb')
Purest = require('purest')
facebook = new Purest(provider:'facebook')

fs = require('fs')
path = require('path')
http = require('request')
Leaderboard = require('agoragames-leaderboard')

APP_ID = '887669707958104'

exports.register = (server, options, next) ->

  asteroids = new Leaderboard('asteroids')


  ###
   * Grant callback to receive facebook logon
   * just pass the info back to the client
   * the session remembers the token
  ###
  server.route
    method: 'GET'
    path: '/login/callback' #
    handler: (request, reply) ->
      grant = request.session.get('grant')
      return reply('try again').redirect('/') unless grant.response?

      facebook.query()
      .get('me')
      .auth(grant.response.access_token)
      .request (err, res, user) ->
        throw new Error(err) if err
        reply(JSON.stringify(user))

  server.route
    method: 'GET'
    path: '/rank/{value}'
    handler: (request, reply) ->
      asteroids.memberAt 1, null, (member) ->
        reply(JSON.stringify(member))

  ###
   * Update the score database
   * the session remembers the token from login
   *
  ###
  server.route
    method: 'GET'
    path: '/score/{value}'
    handler: (request, reply) ->
      grant = request.session.get('grant')
      return reply('try again') unless grant.response?
      facebook.query()
      .get('me')
      .auth(grant.response.access_token)
      .request (err, res, user) ->


        asteroids.rankMember(user.id, parseInt(request.params.value,10), APP_ID)

        scores = {}
        scores['20150301'] = parseInt(request.params.value,10)
        scores['20150302'] = parseInt(request.params.value,10)
        scores['20150303'] = parseInt(request.params.value,10)


        root = 'https://darkoverlordofdata.firebaseio.com/facebook/'
        url = root+user.id+'/'+APP_ID+'.json?auth='+process.env.FIREBASE_AUTH

        http.put url:url, form:JSON.stringify(scores), (err, res, body) ->
          throw new Error(err) if err
          reply(JSON.stringify(body))



  next()
  return

exports.register.attributes = name: 'scores'
