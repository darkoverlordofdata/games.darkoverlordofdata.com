# Base routes for default index/root path, about page, 404 error pages, and others..
exports.register = (server, options, next) ->
  server.route [
    {
      method: "GET"
      path: "/katra/run"
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run'
          return

        id: "run"
    }
    {
      method: "GET"
      path: "/katra/sttr1"
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=STTR1'
          return

        id: "sttr1"
    }
    {
      method: "GET"
      path: "/katra/wumpus"
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run/?basic=atari&program=WUMPUS'
          return

        id: "wumpus"
    }
    {
      method: "GET"
      path: "/katra/eliza"
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run/?basic=gwbasic&program=eliza'
          return

        id: "eliza"
    }
    {
      method: "GET"
      path: "/katra/oregon"
      config:
        handler: (request, reply) ->
          reply.redirect 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=OREGON'
          return

        id: "oregon"
    }
  ]
  next()
  return

exports.register.attributes = name: "katra"
