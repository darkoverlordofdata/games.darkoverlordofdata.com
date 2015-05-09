###
  Cakefile

###
fs = require('fs')
util = require 'util'
{exec} = require "child_process"
{nfcall} = require 'q'
orm = require('./tools/fire-forge')
Firebase = require('firebase')

task "trigger:cache", "create triggers", ->
  trigger = new Firebase('https://darkoverlordofdata.firebaseio.com/development/trigger')
  trigger.authWithCustomToken(process.env.FIREBASE_AUTH, (err) -> throw err if err)
  trigger.update('invalidate_cache': true, (err) -> process.exit())

task "trigger:reset", "create triggers", ->
  trigger = new Firebase('https://darkoverlordofdata.firebaseio.com/development/trigger')
  trigger.authWithCustomToken(process.env.FIREBASE_AUTH, (err) -> throw err if err)
  trigger.update('reset_leaderboard': false, (err) -> process.exit())



#task "orm:dev", "make db in development", ->
#
#  dbinit orm('https://darkoverlordofdata.firebaseio.com/development',
#    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()
#
#task "orm:tst", "make db in test", ->
#
#  dbinit orm('https://darkoverlordofdata.firebaseio.com/test',
#    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()
#
#task "orm:prd", "make db in production", ->
#
#  dbinit orm('https://darkoverlordofdata.firebaseio.com/production',
#    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()
#
###
 * Initialize the selected environment
###
dbinit = (db, done) ->
  db.create 'game',
    active: true
    name: 'Asteroid Simulator'
    slug: 'asteroids'
    url: 'https://darkoverlordofdata.com/asteroids'
    leaderboard: 0
    queue: 'https://asteroids-d16a.firebaseio.com/scores/'
    token: 'ASTEROIDS_D16A'
    scoring: 'highScore'
    author: 'darkoverlordofdata'
    description: 'Classic Space Rocks using modern physics'
    version: '0.0.1'
    icon: 'asteroids36.png'
    main: 'asteroids.html'
    height: 600
    width: 800
  , (e, post) ->
    id = post.id
    console.log('created with id', id)

  db.create 'katra',
    active: true,
    slug: 'sttr1',
    title: 'Katra . . .',
    description: 'Like, beam me up, dude.',
    image: 'assets/katra.png'
    url: 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=STTR1'
  , (e, post) ->
    id = post.id
    console.log('created with id', id)

  db.create 'katra',
    active: true,
    slug: 'wumpus',
    title: 'Hunt the Wumpus',
    description: 'What\'s a Wumpus?',
    image: 'assets/wumpus.png'
    url: 'https://darkoverlordofdata.com/katra/run/?basic=atari&program=WUMPUS'
  , (e, post) ->
    id = post.id
    console.log('created with id', id)

  db.create 'katra',
    active: true,
    slug: 'eliza',
    title: 'Eliza',
    description: 'A shrink with a \'tude.',
    image: 'assets/wumpus.png'
    url: 'https://darkoverlordofdata.com/katra/run/?basic=gwbasic&program=eliza'
  , (e, post) ->
    id = post.id
    console.log('created with id', id)

  db.create 'katra',
    active: true,
    slug: 'oregon',
    title: 'Oregon',
    description: 'Why do you put your wagons in a circle?<br>To get better Wi-Fi!',
    image: 'assets/oregon.png'
    url: 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=OREGON'
  , (e, post) ->
    id = post.id
    console.log('created with id', id)
    done()