###
 * Site Plugins
###
##
#
#
module.exports =

  #|--------------------------------------------------------------------------
  #| good
  #|--------------------------------------------------------------------------
  #|
  #| Logging:
  #|
  #|
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

  #|--------------------------------------------------------------------------
  #| cache/memjs
  #|--------------------------------------------------------------------------
  #|
  #| custom cacheing
  #|
  #|
  './cache/memjs': {}

  #|--------------------------------------------------------------------------
  #| db/firebase
  #|--------------------------------------------------------------------------
  #|
  #| database connection to fiebase
  #|
  #|
  './db/firebase': {}

  #|--------------------------------------------------------------------------
  #| errors
  #|--------------------------------------------------------------------------
  #|
  #| custom error handling
  #|
  #|
  './errors': {}

  #|--------------------------------------------------------------------------
  #| yar
  #|--------------------------------------------------------------------------
  #|
  #| session management
  #|
  #|
  'yar':
    cookieOptions:
      password: process.env.OPENSHIFT_SECRET_TOKEN ? 'iVY0kAZ1iSBWT48dG7y5dzBq2BZYUmG2'
      isSecure: process.env.NODE_ENV is 'production'
      clearInvalid: true

  #|--------------------------------------------------------------------------
  #| hapi-named-routes
  #|--------------------------------------------------------------------------
  #|
  #|
  'hapi-named-routes': {}

  #|--------------------------------------------------------------------------
  #| hapi-cache-buster
  #|--------------------------------------------------------------------------
  #|
  #|
  'hapi-cache-buster': {}

  #|--------------------------------------------------------------------------
  #| public
  #|--------------------------------------------------------------------------
  #|
  #| public assets
  #|
  '../application/public': {}

  #|--------------------------------------------------------------------------
  #| applications
  #|--------------------------------------------------------------------------
  #|
  #| Basic stuff - hime page, about, etc
  #|
  '../application/base': {}

  #|--------------------------------------------------------------------------
  #| katra
  #|--------------------------------------------------------------------------
  #|
  #| Dispatch to run a katra
  #|
  '../application/katra': {}

  #|--------------------------------------------------------------------------
  #| games
  #|--------------------------------------------------------------------------
  #|
  #| Dispatch html5 game
  #|
  '../application/games': {}

  #|--------------------------------------------------------------------------
  #| leaderboard
  #|--------------------------------------------------------------------------
  #|
  #| Leaderboard application
  #|
  '../application/leaderboard': {}

