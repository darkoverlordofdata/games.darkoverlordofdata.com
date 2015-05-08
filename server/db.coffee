###
 * DB operations
###
##
#
unless process.env.FIREBASE_AUTH
  process.exit(console.log('Environment FIREBASE_AUTH not set'))


EXPIRES = 60000 # cache expiry
#
# wow - moving to firebase replaced:
#
# fb
# grant-hapi
# purest
# request
# sequelize
# sqlite3
#
# plus a bunch of complexity with uri callbacks
#
exports.register = (server, options, next) ->

  Firebase = require("firebase")

  env = if process.env.NODE_ENV is 'production' then 'production' else 'development'
  dbRoot = 'https://darkoverlordofdata.firebaseio.com/'+env+'/'

  errorHandler = (err) ->
    throw err if err

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
      generateKey: (model, where) -> model+JSON.stringify(where)

    #
    # Find by criteria
    #
    method: (model, where, next) ->

      db = new Firebase(dbRoot+model.toLowerCase())
      db.authWithCustomToken(process.env.FIREBASE_AUTH, errorHandler)

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
      db.authWithCustomToken(process.env.FIREBASE_AUTH, errorHandler)
      db.on 'value', (data) ->
        db.off()
        next(null, (val for key, val of data.val()))

  next()
  return

exports.register.attributes = name: 'db'
