###
 * DB operations
 *
 * Data on FirebaseIO
 *
###
##
#
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

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


#
#
exports.register = (server, options, next) ->

  path = require('path')
  dbPath = path.resolve(__dirname, '../../db')
  orm = require('ormfire')(dbPath, process.env.FIREBASE_AUTH).init()

  EXPIRES = 0 # no expiration


  # Check in
  #system.update('info': server.info)

  ###
   * Clear Cache?
  ###
#  invalidate_cache = new Firebase(sysRoot+'trigger/invalidate_cache')
#  invalidate_cache.on 'value', (data) ->
#    if data.val() is true
#      system.update(trigger:invalidate_cache: false)
#      server.methods.cache.flush (err, res) ->
#        console.log err if err?
#        console.log 'Cache Flushed: '+JSON.stringify(res)

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
    method: (model, options, next) ->

      cache_key = model+JSON.stringify(options)

      server.methods.cache.get cache_key, (err, val) ->
        return next(null, JSON.parse(val)) if val?
        orm[model].find(options, true).then (data) ->
          server.methods.cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
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

      server.methods.cache.get cache_key, (err, val) ->
        return next(null, JSON.parse(val)) if val?
        orm[model].findAll(true).then (data) ->
          server.methods.cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
          next(null, data)

  next()
  return

exports.register.attributes = name: 'db'
