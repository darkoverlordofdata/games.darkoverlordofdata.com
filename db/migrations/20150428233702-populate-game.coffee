"use strict"
module.exports =
  up: (queryInterface, Sequelize) ->

    Games = require('../models/game')(queryInterface.sequelize, Sequelize)

    Games.sync().then ->
      Games.create
        active: 1
        name: 'Asteroid Simulator'
        slug: 'asteroids'
        url: 'https://github.com/darkoverlordofdata/asteroids'
        author: 'darkoverlordofdata'
        description: 'Classic Asteroids using modern physics'
        version: '0.0.1'
        icon: 'asteroids36.png'
        main: 'asteroids.html'
        height: 600
        width: 800

  down: (queryInterface, Sequelize) ->
