###
 * DB operations
###
##
#
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))


EXPIRES = 60000 # cache expiry
#
# wow - moving to firebase replaced:
#
# fb
# grant-hapi
# purest
# request
# sequelize :(
# sqlite3
#
# plus a bunch of complexity with uri callbacks
#
exports.register = (server, options, next) ->

  Firebase = require('firebase')
  memjs = require('memjs')
  cache = memjs.Client.create()


  env = if process.env.NODE_ENV is 'production' then 'production' else 'development'
  dbRoot = 'https://darkoverlordofdata.firebaseio.com/'+env+'/'

  trigger = new Firebase(dbRoot+'trigger')
  invalidate_cache = new Firebase(dbRoot+'trigger/invalidate_cache')
  invalidate_cache.on 'value', (value) ->
    trigger.update(invalidate_cache: 0)

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

#      cache_key = model+JSON.stringify(where)
#
#      cache.get cache_key, (err, val) ->
#        if val?
#          console.log '=========================='
#          console.log 'got '+model+JSON.stringify(where)+'from cache'
#          console.log String(val)
#          console.log '=========================='
#          return next(null, JSON.parse(val))
#
#        else
        db = new Firebase(dbRoot+model.toLowerCase())
        db.authWithCustomToken(process.env.FIREBASE_AUTH, errorHandler)

        field = Object.keys(where)[0]
        value = where[field]

        db.orderByChild(field).equalTo(value).once 'child_added', (model) ->
          data = model.val()
#          cache.set(cache_key, JSON.stringify(data), null, 60)
          next(null, data)

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

#      cache.get model, (err, val) ->
#        if val?
#          console.log '=========================='
#          console.log 'got '+model+'from cache'
#          console.log String(val)
#          console.log '=========================='
#          return next(null, JSON.parse(val))
#
#        else
        db = new Firebase(dbRoot+model.toLowerCase())
        db.authWithCustomToken(process.env.FIREBASE_AUTH, errorHandler)
        db.on 'value', (data) ->
          db.off()
          data = (val for key, val of data.val())
#          cache.set(model, JSON.stringify(data), null, 60)
          return next(null, data)

  next()
  return

exports.register.attributes = name: 'db'
