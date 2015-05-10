#|
#|--------------------------------------------------------------------------
#| Plugins
#|--------------------------------------------------------------------------
#|
#| Plugins
#|
#|
module.exports =

  'good':
    opsInterval: if process.env.NODE_ENV is 'production' then 60000 else 15000
    reporters: [
      reporter: 'good-console'
      args: [
        ops: "*"
        request: "*"
        log: "*"
        response: "*"
        error: "*"
      ]
    ]
  './cache/memjs': {}
  './db/firebase': {}
  './errors': {}
  'yar':
    cookieOptions:
      password: process.env.OPENSHIFT_SECRET_TOKEN ? 'iVY0kAZ1iSBWT48dG7y5dzBq2BZYUmG2'
      isSecure: process.env.NODE_ENV is 'production'
      clearInvalid: true
  'hapi-named-routes': {}
  'hapi-cache-buster': {}
  '../application/public': {}
  '../application/base': {}
  '../application/katra': {}
  '../application/games': {}
  '../application/leaderboard': {}

