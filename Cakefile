#+--------------------------------------------------------------------+
#| Cakefile
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2012
#+--------------------------------------------------------------------+
#|
#| This file is a part of liquid.coffee
#|
#| liquid.coffee is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Cakefile
#

fs = require('fs')
util = require 'util'
{exec} = require "child_process"
{nfcall} = require 'q'
orm = require('./firebase-orm')

task "orm:dev", "make db", ->

  dbinit orm('https://darkoverlordofdata.firebaseio.com/development',
    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()

task "orm:tst", "make db", ->

  dbinit orm('https://darkoverlordofdata.firebaseio.com/test',
    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()

task "orm:prd", "make db", ->

  dbinit orm('https://darkoverlordofdata.firebaseio.com/production',
    process.env.FIREBASE_AUTH, ['game', 'katra']), -> process.exit()

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