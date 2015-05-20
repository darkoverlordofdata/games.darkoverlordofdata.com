###
 * Leaderboard application
###
##
#
exports.register = (server, options, next) ->

  Leaderboard = require('agoragames-leaderboard')
  Firebase = require('firebase')
  scoring = require('./scoring')
  config = require('./config')
  redis = require('./redis')
  # options cache
  scoreBy = {}
  titles = {}
  names = {}
  queues = {}

  ###
   Initialize the leaderboard queue for each game
  ###
  server.methods.findAll 'Game', (err, games) ->
    games.forEach (game) ->
      return unless game.active
      return unless game.leaderboard  # is it active?
      return unless game.queue        # is there a queue url?

      #
      # cache leaderboard options
      #
      scoreBy[game.slug] = {}
      titles[game.slug] = {}

      server.methods.findAll 'Leaderboard', where: slug: game.slug, (err, leaderboards) ->
        if leaderboards.length is 1
          # just use the slug
          scoreBy[game.slug][leaderboards[0].title] = leaderboards[0].scoring
          titles[game.slug][leaderboards[0].title] = game.slug
          names[game.slug] = [leaderboards[0].title]
        else
          # use compound name
          leaderboards.forEach (leaderboard) ->
            scoreBy[game.slug][leaderboard.title] = leaderboard.scoring
            titles[game.slug][leaderboard.title] = game.slug+': '+leaderboard.title
            names[game.slug+': '+leaderboard.title] = leaderboard.title


      #
      # Connect to the queue
      #
      queues[game.slug] = queue = new Firebase(game.queue)
      unless process.env[game.token]?
        process.exit(console.log('Environment '+game.token+' not set'))

      queue.authWithCustomToken(process.env[game.token], (err) -> throw err if err)
      #
      # Wait for a score message in the queue:
      #
      #   dt: 1432141196453
      #   id: asteroids
      #   title: 'Asteroid Simulator'
      #   appId: 887669707958104
      #   userId: 676767676765656
      #   date: yyyymmdd
      #   score: 42
      #
      queue.on 'value', (queue) ->
        return unless queue.val()?
        msgs = (val for key, val of queue.val())
        msgs.forEach (msg, index) ->

          console.log 'score:', msg

          # make sure it's a valid message
          return if msg.id isnt game.slug
          return unless scoreBy[msg.id]?[msg.title]?

          bestScore = scoreBy[msg.id][msg.title]
          title = titles[msg.id][msg.title]

          #
          # Create the redis adapter for this leaderboard title
          #
          leaderboard = new Leaderboard(title, config, redis)
          leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

          leaderboard.scoreFor msg.userName, (currentScore) ->
            leaderboard.rankMemberIf scoring[bestScore], msg.userName, parseInt(msg.score, 10), currentScore, null, (member) ->
              leaderboard.disconnect()
              #
              # clean up the queue if that was the last one
              #
              queue.ref().remove() if index is msgs.length-1


  ###
   *
   * Route to display leaderboard by name
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
      leaderboard = new Leaderboard(request.params.name, config, redis)
      leaderboard.redisConnection.auth(redis.auth_pass) if redis.auth_pass?

      leaderboard.leaders 1, withMemberData: false, (leaders) ->
        reply.view 'leaderboard',
          name          : names[request.params.name]
          leaderboard   : leaders

        leaderboard.disconnect()


  #http://bosco.com:3000
  #/leaderboard/score
  #POST
  #{"id":"asteroids","title":"Asteroid Simulator","appId":7777777,"userId": 66666666,"date":20150520,"score": 42}

  ###
   * Push the score to the appropriate queue
   * Use this route when the client doesn't support Firebase
  ###
  server.route
    method: 'POST'
    path: '/leaderboard/score'
    handler: (request, reply) ->
      form = request.payload
      if queues[form.id]?
        queues[form.id].push(form)


  next()
  return

exports.register.attributes = name: 'leaderboard'
