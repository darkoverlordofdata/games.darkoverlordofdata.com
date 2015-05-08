unless process.env.FACEBOOK_APPID
  process.exit(console.log('Environment FACEBOOK_APPID not set'))
unless process.env.FACEBOOK_APPSECRET
  process.exit(console.log('Environment FACEBOOK_APPSECRET not set'))
unless process.env.SECRET
  process.exit(console.log('Environment SECRET not set'))
unless process.env.FIREBASE_AUTH
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

PROD = process.env.NODE_ENV is 'production'

module.exports =

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
  port: if PROD then process.env.OPENSHIFT_NODEJS_PORT else 3000


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
  host: if PROD then process.env.OPENSHIFT_NODEJS_IP else 'bosco.com'


  score_auth: process.env.FIREBASE_AUTH

  db_host: if PROD then process.env.OPENSHIFT_MONGODB_DB_HOST else 'localhost'
  db_port: if PROD then process.env.OPENSHIFT_MONGODB_DB_PORT else 27017
  db_user: if PROD then process.env.OPENSHIFT_MONGODB_DB_USER else `undefined`
  db_pass: if PROD then process.env.OPENSHIFT_MONGODB_DB_PASS else `undefined`


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

  opsInterval: if PROD then 15000 else 5000

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
    __dirname+'/application/scores'
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
      password: process.env.SECRET
      isSecure: PROD
      clearInvalid: true



  leaderboard:
    pageSize: 25
    reverse: false
    memberKey: 'member'
    rankKey: 'rank'
    scoreKey: 'score'
    memberDataKey: 'member_data'
    memberDataNamespace: 'member_data'

