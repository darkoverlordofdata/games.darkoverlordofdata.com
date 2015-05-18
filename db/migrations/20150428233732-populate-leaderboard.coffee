"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->

    Leaderboards = queryInterface.sequelize.models.Leaderboard

    Leaderboards.sync().then ->
      Leaderboards.create(
        active: true
        slug: 'asteroids'
        title: 'Asteroid Simulator'
        description: 'Asteroid Simulator'
        scoring: 'highScore'
        createdAt: Date.now()
        updatedAt: 0
      ).then ->
        done()

  down: (queryInterface, Sequelize, done) ->
