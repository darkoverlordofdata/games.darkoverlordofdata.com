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
  server.route [
    {
      method: 'GET'
      path: '/katra/run'
      config:
        id: 'run'
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run'

    }
    {
      method: 'GET'
      path: '/katra/{name}'
      config:
        handler: (request, reply) ->
          server.methods.find 'Katra', {where: slug:request.params.name}, (err, katra) ->
            reply.redirect katra.url

    }
  ]
  next()

exports.register.attributes = name: 'katra'
