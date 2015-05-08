###
 * Public assets
###
##
#
exports.register = (server, options, next) ->

  path = require('path')

  server.route [
    {
      method: "GET"
      path: "/assets/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/assets")

        id: "assets"
    }
    {
      method: "GET"
      path: "/css/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/css")

        id: "css"
    }
    {
      method: "GET"
      path: "/fonts/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/fonts")

        id: "fonts"
    }
    {
      method: "GET"
      path: "/game/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/game")

        id: "games"
    }
    {
      method: "GET"
      path: "/img/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/img")

        id: "img"
    }
    {
      method: "GET"
      path: "/js/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/js")

        id: "js"
    }
    {
      method: "GET"
      path: "/tpl/{path*}"
      config:
        handler:
          directory:
            path: path.join(server.settings.app.base, "public/tpl")

        id: "tpl"
    }
  ]
  next()
  return

exports.register.attributes = name: "assets"
