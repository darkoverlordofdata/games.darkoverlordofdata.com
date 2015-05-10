###
 * Cache
 *
 *
###
##
#
#
#
exports.register = (server, options, next) ->

  memjs = require('memjs')
  cache = memjs.Client.create()

  server.method
    name: 'cache.get'
    method: (key, next) ->
      cache.get(key, next)
      return

  server.method
    name: 'cache.set'
    method: (key, value, next) ->
      cache.get(key, value, next)
      return

  server.method
    name: 'cache.flush'
    method: (next) ->
      cache.flush(next)
      return


  next()
  return

exports.register.attributes = name: 'cache'
