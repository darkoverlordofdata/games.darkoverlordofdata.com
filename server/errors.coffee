exports.register = (server, options, next) ->

  #
  # End of the line - Display a 404 error
  #
  server.route [
    {
      method: '*'
      path: '/{path*}'
      config:
        handler: (request, reply) ->
          reply.view('404', url: request.url).code(404)

    }
  ]

  #
  # Check for internal errors - Display 5xx errors
  #
  server.ext 'onPreResponse', (request, reply) ->
    response = request.response
    return reply.continue() if not response.isBoom
    reply.view('5xx', message: response.message, error: response.output.payload).code(500)



  next()
  return

exports.register.attributes = name: 'errors'
