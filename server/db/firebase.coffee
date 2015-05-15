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
 * General MemChachier Errors
###
cacheErrorHandler = (err, val) ->
  if err?
    console.log err
    console.log String(val)


#
#
exports.register = (server, options, next) ->

  EXPIRES = 0 # no expiration
  path = require('path')
  dbPath = path.resolve(__dirname, '../../db')
  orm = require('ormfire')(dbPath, process.env.FIREBASE_AUTH)
  .init (queryInterface, Sequelize) ->
    sequelize = queryInterface.sequelize

    ###
     * Started at ...
    ###
    sequelize.ref.child('system')
    .update(info: server.info)

    ###
     * Create triggers
    ###
    sequelize.ref.child('system/trigger')
    .update(invalidate_cache: false)

    ###
     * Wait for triggers
    ###
    sequelize.ref.child('system/trigger/invalidate_cache')
    .on 'value', (data) ->
      if data.val() is true
        sequelize.ref.child('system/trigger')
        .update(invalidate_cache: false)
        server.methods.cache.flush (err, res) ->
          console.log err if err?
          console.log 'Cache Flushed: '+JSON.stringify(res)



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
