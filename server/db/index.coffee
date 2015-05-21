###
 * OrmFire Plugin
 *
 * Manages ORM startup and cacheing
 *
###
##
#
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

#
#
exports.register = (server, options, next) ->

  EXPIRES = 1 # no expiration

  path = require('path')
  models = path.resolve(__dirname, '../../db')
  migrations = path.resolve(models, './migrations')

  orm = require('ormfire')(models, process.env.FIREBASE_AUTH)
  orm.init (queryInterface, Sequelize) ->
    sequelize = queryInterface.sequelize

    ###
     * Check for migrations
    ###
    migrator = sequelize.getMigrator(path:migrations, filesFilter: /\.coffee$/)
    migrator.migrate method: 'up', ->

      ###
       * Initialize System
      ###
      sequelize.ref.child('system').update(info: server.info)
      sequelize.ref.child('system/trigger').update(invalidate_cache: false)
      sequelize.ref.child('system/trigger/invalidate_cache')
      .on 'value', (data) ->
        if data.val() is true
          sequelize.ref.child('system/trigger').update(invalidate_cache: false)
          server.methods.cache.flush (err, res) ->
            console.log err if err?
            console.log 'Cache Flushed: '+JSON.stringify(res)

      console.log 'firebase ready...'



  ###
   * Server Method Find
   *
   * Find one record that meets criterea
  ###
  server.method

    name: 'db.find'
    #
    # Find by criteria
    #
    method: (model, options, next) ->

      cache = options.cache
      cache = true unless cache?
      cache_key = model+JSON.stringify(options)
      if cache
        server.methods.cache.get cache_key, (err, val) ->
          return next(null, JSON.parse(val)) if val?
          orm[model].find(options, true).then (data) ->
            server.methods.cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
            return next(null, data)
      else
        orm[model].find(options, true).then (data) ->
          server.methods.cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
          return next(null, data)

  ###
   * Server Method FindAll
   *
   * Find all records that meet criterea
  ###
  server.method

    name: 'db.findAll'
    #
    # Find all data for the model
    #
    method: (model, options, next) ->

      unless next?
        next = options
        options = {}

      cache_key = model
      server.methods.cache.get cache_key, (err, val) ->
        return next(null, JSON.parse(val)) if val?
        orm[model].findAll(options, true).then (data) ->
          server.methods.cache.set(cache_key, JSON.stringify(data), cacheErrorHandler, EXPIRES)
          next(null, data)


  ###
   * Server Method Create
   *
   * Creates a new model instance
  ###
  server.method

    name: 'db.create'

    method: (model, attrs, next) ->
      orm[model].create(attrs).then (result) ->
        next(null, result)




  next()
  return

exports.register.attributes = name: 'db'

###
 * General MemChachier Errors
###
cacheErrorHandler = (err, val) ->
  if err?
    console.log err
    console.log String(val)

