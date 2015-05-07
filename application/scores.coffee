#
# scores routes:
#
#
Firebase = require('firebase')
Leaderboard = require('agoragames-leaderboard')

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

###
 * Select highest score
###
highScore = (member, currentScore, score, memberData, leaderboardOptions) ->
  return true if !currentScore?
  return true if score > currentScore
  false

###
 * Select lowest score
###
lowScore = (member, currentScore, score, memberData, leaderboardOptions) ->
  return true if !currentScore?
  return true if score < currentScore
  false

leaderboards = [
  {
    name: 'asteroids'
    url: 'https://asteroids-d16a.firebaseio.com/scores/'
    auth: 'ASTEROIDS_D16A'
    bestScore: highScore
  }
]

exports.register = (server, options, next) ->

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

  #
  # Start Leaderboard message processing
  #
  leaderboards.forEach (board) ->

    db = new Firebase(board.url)

    #
    # Authorize the firebase connection
    #
    db.authWithCustomToken process.env[board.auth], (err, auth) ->
      if err
        console.log 'Error connecting to '+board.name
        console.log err
      else
        console.log 'Authorized to update '+board.name+' leaderboard'

    #
    # Wait for scores
    #
    db.on 'value', (snap) ->
      return unless snap.val()?
      console.log snap.val()

      #
      # Create the redis adapter for this leaderboard
      #
      do (leaderboard = new Leaderboard(board.name, server.settings.app.leaderboard, redis)) ->

        #
        # Authorize the redis connection
        #
        leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

        # copy to a list
        vals = (val for key, val of snap.val())

        #
        # Post each score to the leaderboard
        #
        vals.forEach (val, index) ->
          leaderboard.scoreFor val.id, (currentScore) ->
            leaderboard.rankMemberIf board.bestScore, val.id, parseInt(val.score,10), currentScore, null, (member) ->
              if index is vals.length-1
                leaderboard.disconnect()
                snap.ref().remove();


  next()
  return

exports.register.attributes = name: 'scores'
