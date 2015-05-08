###
 * Site configuration
###
##
#
#
module.exports =

  env: if process.env.NODE_ENV? then process.env.NODE_ENV else 'development'
  #|
  #|--------------------------------------------------------------------------
  #| Site Name
  #|--------------------------------------------------------------------------
  #|
  #| Title for your site
  #|
  #|
  site_name: 'Game*O*Rama'

  #|
  #|--------------------------------------------------------------------------
  #| System Path
  #|--------------------------------------------------------------------------
  #|
  #| Where the server script lives
  #|
  #|
  base: __dirname

  #|
  #|--------------------------------------------------------------------------
  #| Plugin Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to application plugins
  #|
  #|
  apps: __dirname+'/application'

  #|
  #|--------------------------------------------------------------------------
  #| View Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to view templates
  #|
  #|
  views: __dirname+'/views'

  #|
  #|--------------------------------------------------------------------------
  #| HTTP Port
  #|--------------------------------------------------------------------------
  #|
  #| The http port to use
  #|
  #|
  port: process.env.OPENSHIFT_NODEJS_PORT ? 3000


  #|
  #|--------------------------------------------------------------------------
  #| Host
  #|--------------------------------------------------------------------------
  #|
  #| Host DNS or IP
  #|
  #| Use hostname instead of localhost for testing
  #| so that cookies will work in hapi.
  #|
  #|
  host: process.env.OPENSHIFT_NODEJS_IP ? 'bosco.com'

  #|
  #|--------------------------------------------------------------------------
  #| Logging
  #|--------------------------------------------------------------------------
  #|
  #| Logging Options
  #|
  #|
  log: [
    ops: "*"
    request: "*"
    log: "*"
    response: "*"
    error: "*"
  ]

  opsInterval: if process.env.NODE_ENV is 'production' then 15000 else 5000

  #|
  #|--------------------------------------------------------------------------
  #| Plugins
  #|--------------------------------------------------------------------------
  #|
  #| Plugins
  #|
  #|
  plugins: [
    'hapi-named-routes'
    'hapi-cache-buster'
    __dirname+'/application/public'
    __dirname+'/application/base'
    __dirname+'/application/katra'
    __dirname+'/application/games'
    __dirname+'/application/leaderboard'
  ]

  #|
  #|--------------------------------------------------------------------------
  #| Assets
  #|--------------------------------------------------------------------------
  #|
  #| managed assets (hapi-assets)
  #|
  #|
  assets:
    development: [
      js: [],
      css: []
    ]
    production: [
      js: [],
      css: []
    ]

  #|
  #|--------------------------------------------------------------------------
  #| Yar Session Software
  #|--------------------------------------------------------------------------
  #|
  #| Session options
  #|
  #|
  yar:
    cookieOptions:
      password: OPENSHIFT_SECRET_TOKEN ? 'iVY0kAZ1iSBWT48dG7y5dzBq2BZYUmG2'
      isSecure: process.env.NODE_ENV is 'production'
      clearInvalid: true



  leaderboard:
    pageSize: 25
    reverse: false
    memberKey: 'member'
    rankKey: 'rank'
    scoreKey: 'score'
    memberDataKey: 'member_data'
    memberDataNamespace: 'member_data'

