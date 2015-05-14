###
  Hook orm
###
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

orm = require('ormfire')(__dirname, process.env.FIREBASE_AUTH).init()

module.exports = orm