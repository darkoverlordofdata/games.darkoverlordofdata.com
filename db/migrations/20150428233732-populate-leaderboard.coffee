"use strict"
Promise = require('promise')

module.exports =
  up: (queryInterface, Sequelize, done) ->

    data = [
      {
        active: true
        slug: 'asteroids'
        title: 'Asteroid Simulator'
        description: 'Asteroid Simulator'
        scoring: 'highScore'
        createdAt: Date.now()
        updatedAt: 0
      }
      {
        active: false
        slug: 'alienzone'
        title: 'Infinity'
        description: 'Take your time'
        scoring: 'highScore'
        createdAt: Date.now()
        updatedAt: 0
      }
      {
        active: false
        slug: 'alienzone'
        title: 'FTL'
        description: 'Beat the clock'
        scoring: 'highScore'
        createdAt: Date.now()
        updatedAt: 0
      }
    ]
    Leaderboards = queryInterface.sequelize.models.Leaderboard

    Leaderboards.sync()
    .then ->
      Promise.all(data.map(Leaderboards.create))
      .then ->
        done()

  down: (queryInterface, Sequelize, done) ->
