"use strict"
Promise = require('promise')

module.exports =
  up: (queryInterface, Sequelize, done) ->

    data = [
      {
        active: true
        name: 'Asteroid Simulator'
        slug: 'asteroids'
        url: 'https://darkoverlordofdata.com/asteroids'
        leaderboard: true
        queue: 'https://asteroids-d16a.firebaseio.com/scores/'
        token: 'ASTEROIDS_D16A'
        author: 'darkoverlordofdata'
        description: 'Classic Space Rocks using modern physics'
        version: '0.0.1'
        icon: 'asteroids36.png'
        main: 'asteroids.html'
        height: 600
        width: 800
        createdAt: Date.now()
        updatedAt: 0
      }
      {
        active: true
        name: 'Alien Zone'
        slug: 'alienzone'
        url: 'https://darkoverlordofdata.com/alienzone-haxe'
        leaderboard: true
        queue: 'https://alienzone.firebaseio.com/scores/'
        token: 'ALIENZONE_D16A'
        author: 'darkoverlordofdata'
        description: 'Matching Space Crystals'
        version: '0.0.1'
        icon: 'favicon.png'
        main: 'index.html'
        height: 600
        width: 800
        createdAt: Date.now()
        updatedAt: 0
      }
    ]
    Games = queryInterface.sequelize.models.Game
    Games.sync()
    .then ->
      Promise.all(data.map(Games.create))
      .then ->
        done()

  down: (queryInterface, Sequelize, done) ->
