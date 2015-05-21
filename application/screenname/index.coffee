###
 * ScreenName application
 *
###
##
#
exports.register = (server, options, next) ->

  lib = require('../lib')


  server.route
    method: 'POST'
    path: '/leaderboard/register'
    handler: (request, reply) ->
      form = request.payload
      return if form.key isnt lib.getKey(form.appId, form.userId)

      data =
        active        : true
        id            : form.userId
        name          : form.name
        description   : form.description
        createdAt     : Date.now()
        updatedAt     : 0

      server.methods.db.find 'Name', where: name: request.params.name, (err, name) ->
        if err then reply(JSON.stringify(err))
        else
          if name is null
            server.methods.db.create 'Name', date, (err) ->
              if err then reply(JSON.stringify(err)) else reply(JSON.stringify(status:'ok'))
          else
            reply(JSON.stringify(status:'inuse'))



  next()
  return

exports.register.attributes = name: 'screenname'
