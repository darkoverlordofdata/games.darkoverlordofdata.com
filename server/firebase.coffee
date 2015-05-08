#
# Db operations
#
EXPIRES = 60000 # cache expiry

exports.register = (server, options, next) ->

  Firebase = require("firebase")

  env = if process.env.NODE_ENV is 'production' then 'production' else 'development'
  dbRoot = 'https://darkoverlordofdata.firebaseio.com/'+env+'/'

  ###
   * Server Method Find
   *
   * Find data that meets criterea
  ###
  server.method

    name: 'find'
    #
    # Register as a cacheable server method
    #
    options:
      cache: expiresIn: EXPIRES
      generateKey: (model, what) -> model+JSON.stringify(what)

    #
    # Find by criteria
    #
    method: (model, where, next) ->

      db = new Firebase(dbRoot+model.toLowerCase())
      db.authWithCustomToken process.env.FIREBASE_AUTH, (err, a) ->
        throw err if err

      field = Object.keys(where)[0]
      value = where[field]

      db.orderByChild(field).equalTo(value).once 'child_added', (model) ->
        next(null, model.val())

  ###
   * Server Method FindAll
   *
   * Get all records for a table
  ###
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

      db = new Firebase(dbRoot+model.toLowerCase())
      db.authWithCustomToken process.env.FIREBASE_AUTH, (err, a) ->
        throw err if err

      db.on 'value', (data) ->
        db.off()
        rows = (val for key, val of data.val())
        next(null, rows)

  next()
  return

exports.register.attributes = name: 'db'
