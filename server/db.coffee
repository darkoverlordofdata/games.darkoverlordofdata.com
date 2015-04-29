exports.register = (server, options, next) ->

  server.expose('models', options);

  server.method

    name: 'findAll'
    #
    # Register as a cacheable server method
    #
    options:
      cache: expiresIn: 60000
      generateKey: (model) -> model
    #
    # Find all data for the model
    #
    method: (model, next) ->
      options[model].findAll(raw:true)
      .then (rows) ->
        next(null, rows)



  next()
  return

exports.register.attributes = name: 'db'
