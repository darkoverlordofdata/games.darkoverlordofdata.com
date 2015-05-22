###
 * Site configuration
###
##
#
#
path = require('path')

module.exports =

  #|
  #|--------------------------------------------------------------------------
  #| Environment
  #|--------------------------------------------------------------------------
  #|
  #| Development/Production
  #|
  #|
  env: if process.env.NODE_ENV? then process.env.NODE_ENV else 'development'

  #|
  #|--------------------------------------------------------------------------
  #| Site Name
  #|--------------------------------------------------------------------------
  #|
  #| Title for your site
  #|
  #|
  siteName: 'Game*O*Rama'

  #|
  #|--------------------------------------------------------------------------
  #| System Path
  #|--------------------------------------------------------------------------
  #|
  #| Where the server script lives
  #|
  #|
  base: path.resolve(__dirname, '../')

  #|
  #|--------------------------------------------------------------------------
  #| Plugin Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to application plugins
  #|
  #|
  apps: path.resolve(__dirname, '../application')

  #|
  #|--------------------------------------------------------------------------
  #| View Path
  #|--------------------------------------------------------------------------
  #|
  #| Path to view templates
  #|
  #|
  views: path.resolve(__dirname, '../views')

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
  #| CORS
  #|--------------------------------------------------------------------------
  #|
  #| Cross-origin resource sharing
  #|
  #| Allow requests from other domains
  #| Enabled in development for functional testing
  #|
  #|
  cors: if process.env.NODE_ENV? then false else true




