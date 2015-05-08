#
# Db operations

#
EXPIRES = 60000 # cache expiry

exports.register = (server, options, next) ->

  server.expose('models', options);

  server.method

    name: 'find'
    #
    # Register as a cacheable server method
    #
    options:
      cache: expiresIn: EXPIRES
      generateKey: (model, what) -> model+JSON.stringify(what)
    #
    # Find by criterea
    #
    method: (model, what, next) ->
      options[model].find(what)
      .then (model) ->
        next(null, model.dataValues)


  server.method

    name: 'findAll'
    #
    # Register as a cacheable server method
    #
    options:
      cache: expiresIn: EXPIRES
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
