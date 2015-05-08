#
# Run application from gh-pages
#
#
# katra routes:
#
#   /run
#   /sttr1
#   /wumpus
#   /eliza
#   /oregon
#
exports.register = (server, options, next) ->

  ###
   * Set up the Katra routes
  ###
  server.route [
    {
      #
      # Facebook iframe canvas
      #
      method: 'POST'
      path: '/katra/run'
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run'

    }
    {
    #
    # Run in iframe
    #
      method: 'GET'
      path: '/katra/run'
      config:
        id: 'run'
        handler: (request, reply) ->
          reply.view 'play_katra',
            katra:
              title: 'Katra BASIC'
              url: 'https://darkoverlordofdata.com/katra/run'

    }
    {
      #
      # Facebook iframe canvas
      #
      method: 'POST'
      path: '/katra/{name}'
      config:
        handler: (request, reply) ->
          server.methods.find 'Katra', slug:request.params.name, (err, katra) ->
            reply.redirect katra.url

    }
    {
      #
      # Run in iframe
      #
      method: 'GET'
      path: '/katra/{name}'
      config:
        handler: (request, reply) ->
          server.methods.find 'Katra', slug:request.params.name, (err, katra) ->
            reply.view 'play_katra', katra: katra

    }
  ]
  next()

exports.register.attributes = name: 'katra'
