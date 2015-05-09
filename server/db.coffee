###
 * DB operations
 *
 * Data on FirebaseIO
 * Cache with MemCachier
 *
###
##
#
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

#
#
exports.register = (server, options, next) ->

  EXPIRES = 0 # no expiration
  Firebase = require('firebase')
  memjs = require('memjs')
  cache = memjs.Client.create()


  env = if process.env.NODE_ENV is 'production' then 'production' else 'development'
  dbRoot = 'https://darkoverlordofdata.firebaseio.com/'+env+'/'

  ###
   * Triggers
  ###
  trigger = new Firebase(dbRoot+'trigger')

  # trigger clear cache
  invalidate_cache = new Firebase(dbRoot+'trigger/invalidate_cache')
  invalidate_cache.on 'value', (data) ->
    if data.val() is true
      trigger.update(invalidate_cache: false)
      cache.flush (err, res) ->
        console.log err if err?
        console.log 'Cache Flushed: '+JSON.stringify(res)

  ###
   * General Firebase Errors
  ###
  fbErrorHandler = (err) ->
    throw err if err

  ###
   * General MemChachier Errors
  ###
  cacheErrorHandler = (err, val) ->
    if err?
      console.log err
      console.log String(val)

  ###
   * Server Method Find
   *
   * Find data that meets criterea
  ###
  server.method

    name: 'find'
    #
    # Find by criteria
    #
    method: (model, where, next) ->

      cache_key = model+JSON.stringify(where)

      cache.get cache_key, (err, val) ->

        return next(null, JSON.parse(val)) if val?

        db = new Firebase(dbRoot+model.toLowerCase())
        db.authWithCustomToken(process.env.FIREBASE_AUTH, fbErrorHandler)

        field = Object.keys(where)[0]
        value = where[field]

        db.orderByChild(field).equalTo(value).once 'child_added', (model) ->
          data = model.val()
          cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
          next(null, data)

  ###
   * Server Method FindAll
   *
   * Get all records for a table
  ###
  server.method

    name: 'findAll'
    #
    # Find all data for the model
    #
    method: (model, next) ->

      cache_key = model

      cache.get cache_key, (err, val) ->

        return next(null, JSON.parse(val)) if val?

        db = new Firebase(dbRoot+model.toLowerCase())
        db.authWithCustomToken(process.env.FIREBASE_AUTH, fbErrorHandler)
        db.on 'value', (data) ->
          db.off()
          data = (val for key, val of data.val())
          cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
          return next(null, data)

  next()
  return

exports.register.attributes = name: 'db'
