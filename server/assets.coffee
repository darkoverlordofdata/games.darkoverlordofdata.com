
exports.register = (server, options, next) ->

  server.route [
    {
      method: "GET"
      path: "/assets/{path*}"
      config:
        handler:
          directory:
            path: "./public/assets"

        id: "assets"
    }
    {
      method: "GET"
      path: "/css/{path*}"
      config:
        handler:
          directory:
            path: "./public/css"

        id: "css"
    }
    {
      method: "GET"
      path: "/fonts/{path*}"
      config:
        handler:
          directory:
            path: "./public/fonts"

        id: "fonts"
    }
    {
      method: "GET"
      path: "/game/{path*}"
      config:
        handler:
          directory:
            path: "./public/game"

        id: "games"
    }
    {
      method: "GET"
      path: "/img/{path*}"
      config:
        handler:
          directory:
            path: "./public/img"

        id: "img"
    }
    {
      method: "GET"
      path: "/js/{path*}"
      config:
        handler:
          directory:
            path: "./public/js"

        id: "js"
    }
    {
      method: "GET"
      path: "/tpl/{path*}"
      config:
        handler:
          directory:
            path: "./public/tpl"

        id: "tpl"
    }
  ]
  next()
  return

exports.register.attributes = name: "assets"
