path = require('path')
BASE = path.resolve(__dirname, '../..')

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
  #| View Extension
  #|--------------------------------------------------------------------------
  #|
  #| The default view filetype that is loaded when no extension is specified
  #|
  #|
  view_ext: 'tpl'

  #|
  #|--------------------------------------------------------------------------
  #| View Engine
  #|--------------------------------------------------------------------------
  #|
  #| The default view engine to use for view_ext
  #|
  #|
  view_engine:  path.resolve(BASE,'./server/config/liquid.coffee')

  #|
  #|--------------------------------------------------------------------------
  #| System Path
  #|--------------------------------------------------------------------------
  #|
  #| Where the server script lives
  #|
  #|
  sys: BASE

  #|
  #|--------------------------------------------------------------------------
  #| Plugin Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to application plugins
  #|
  #|
  apps: path.resolve(BASE, './plugins')

  #|
  #|--------------------------------------------------------------------------
  #| View Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to view templates
  #|
  #|
  views: path.resolve(BASE, './server/views')

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
  #|
  host: process.env.OPENSHIFT_NODEJS_IP ? '127.0.0.1'


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
    './errors'
    '../plugins/public'
    '../plugins/base'
    '../plugins/katra'
    '../plugins/games'
    '../plugins/liquid'
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