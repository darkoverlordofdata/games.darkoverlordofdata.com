###
 * Leaderboard application
###
##
#
Firebase = require('firebase')
Leaderboard = require('agoragames-leaderboard')
scoring = require('./lib/scoring')
redis = require('./lib/redis')

exports.register = (server, options, next) ->

  ###
   Initialize the leaderboard queue for each game
  ###
  server.methods.findAll 'Game', (err, games) ->

    games.forEach (game) ->
      return unless game.queue?       # is there a queue url?
      return unless game.leaderboard  # is it active?

      bestScore = scoring[game.scoring]
      #
      # Connect to the queue
      #
      db = new Firebase(game.queue)

      #
      # Authorize access
      #
      db.authWithCustomToken process.env[game.token], (err, auth) ->
        if err
          console.log 'Error connecting to '+game.name
          console.log err
        else
          console.log 'Authorized to update '+game.name+' leaderboard'

      #
      # Wait for a score in the queue
      #
      db.on 'value', (msg) ->
        return unless msg.val()?
        console.log msg.val()

        #
        # Create the redis adapter for this leaderboard
        #
        do (leaderboard = new Leaderboard(game.name, server.settings.app.leaderboard, redis)) ->

          #
          # Authorize the redis connection
          #
          leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

          # copy values to a list
          vals = (val for key, val of msg.val())

          #
          # Post each score to the leaderboard
          #
          vals.forEach (val, index) ->
            leaderboard.scoreFor val.id, (currentScore) ->
              leaderboard.rankMemberIf bestScore, val.id, parseInt(val.score,10), currentScore, null, (member) ->
                #
                # if that was the last one, them clean up
                #
                if index is vals.length-1
                  leaderboard.disconnect()
                  msg.ref().remove();


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


  next()
  return

exports.register.attributes = name: 'scores'
