###
  Cakefile

###
fs = require('fs')
path = require('path')

unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

task "trigger:cache", "set trigger invalidate_cache", ->
  orm = require('ormfire')(path.resolve(__dirname, './db'), process.env.FIREBASE_AUTH)
  orm.init (queryInterface, Sequelize) ->

    sequelize = queryInterface.sequelize
    sequelize.ref.child('system/trigger').update(invalidate_cache: true)


