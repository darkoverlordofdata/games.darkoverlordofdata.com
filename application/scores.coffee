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
config = require('../config')

if process.env.rediscloud_39a84?
  rediscloud = JSON.parse(process.env.rediscloud_39a84)
  redis =
    host: rediscloud.hostname
    port: rediscloud.port
    auth_pass: rediscloud.password
    options: auth_pass: rediscloud.password
else
  redis =
    host: 'localhost'
    port: 6379


highScore = (member, currentScore, score, memberData, leaderboardOptions) ->
  return true if !currentScore?
  return true if score > currentScore
  false

lowScore = (member, currentScore, score, memberData, leaderboardOptions) ->
  return true if !currentScore?
  return true if score < currentScore
  false

APP_ID = '887669707958104'

exports.register = (server, options, next) ->

  Firebase = require('firebase')
  scores = new Firebase('https://asteroids-d16a.firebaseio.com/scores/')
  scores.authWithCustomToken process.env.ASTEROIDS_D16A, (err, auth) ->
    if err
      console.log 'Error connecting to asteroids'
      console.log err
    else
      console.log 'Authorized to update asteroids'
      console.log auth


  scores.on 'value', (dataSnapshot) ->

    leaderboard = new Leaderboard('asteroids', config.leaderboard, redis)
    leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?
    o = dataSnapshot.val()
    if o isnt null
      console.log o
      for k, v of o
        console.log 'Key: '+k
        console.log v
        leaderboard.scoreFor v.id, (currentScore) ->
          leaderboard.rankMemberIf highScore, v.id, parseInt(v.score,10), currentScore, null, (member) ->
            leaderboard.disconnect()


  ###
   *
   * /login/callback
   *
   * Grant callback to receive facebook logon
   * just pass the info back to the client
   * the session remembers the token
   *
   * We get here via:
   *  /connect/facebook
   *  /connect/google
   *  /connect/twitter
   *
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


  ###
   *
   * /leaderboard/{name}
   *
   * Show top 10 rankings for the specified game
   *
  ###
  server.route
    method: 'GET'
    path: '/leaderboard/{name}'
    handler: (request, reply) ->
      leaderboard = new Leaderboard(request.params.name, server.settings.app.leaderboard, redis)
      leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

      leaderboard.leaders 1, withMemberData: false, (leaders) ->
        reply.view 'leaderboard',
          name: request.params.name
          leaderboard: leaders
        console.log 'disconnect /leaderboard/{name}'
        leaderboard.disconnect()



  ###
   *
   * /score/{leaderboard}/{user}/{value}
   *
   *
   * Update the members score in the leaderboard
  ###
  server.route
    method: 'GET'
    path: '/score/{leaderboard}/{user}/{value}'
    handler: (request, reply) ->
      leaderboard = new Leaderboard(request.params.leaderboard, server.settings.app.leaderboard, redis)
      leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

      leaderboard.scoreFor request.params.user, (currentScore) ->
        leaderboard.rankMemberIf highScore, request.params.user, parseInt(request.params.value,10), currentScore, null, (member) ->
          reply.redirect '/leaderboard/'+request.params.leaderboard
          console.log 'disconnect /score/{leaderboard}/{user}/{value}'
          leaderboard.disconnect()




  server.route
    method: 'POST'
    path: '/score/asteroids'
    handler: (request, reply) ->
      grant = request.session.get('grant')
      console.log grant.response
      reply(JSON.stringify(grant.response))



  next()
  return

exports.register.attributes = name: 'scores'
