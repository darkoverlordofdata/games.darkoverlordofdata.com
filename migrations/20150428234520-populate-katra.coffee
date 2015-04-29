"use strict"
module.exports =
  up: (queryInterface, Sequelize) ->

    Katras = require('../models/katra')(queryInterface.sequelize, Sequelize)

    Katras.sync().then ->
      Katras.create(
        active: 1,
        slug: 'sttr1',
        title: 'Katra . . .',
        description: 'Like, beam me up, dude.',
        image: 'assets/katra.png'
      ).then ->
        Katras.create(
          active: 1,
          slug: 'wumpus',
          title: 'Hunt the Wumpus',
          description: 'What\'s a Wumpus?',
          image: 'assets/wumpus.png'
        ).then ->
          Katras.create(
            active: 1,
            slug: 'eliza',
            title: 'Eliza',
            description: 'A shrink with a \'tude.',
            image: 'assets/wumpus.png'
          ).then ->
            Katras.create(
              active: 1,
              slug: 'oregon',
              title: 'Oregon',
              description: 'Why do you put your wagons in a circle?<br>To get better Wi-Fi!',
              image: 'assets/oregon.png'
            )




  down: (queryInterface, Sequelize) ->
