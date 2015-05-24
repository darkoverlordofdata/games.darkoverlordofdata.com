"use strict"
Promise = require('promise')

module.exports =
  up: (queryInterface, Sequelize, done) ->

    data = [
      {
        active: true
        name: 'The Deluding of Gylfe'
        slug: 'ganglere'
        url: 'https://darkoverlordofdata.com/ganglere'
        leaderboard: true
        queue: 'https://ganglere.firebaseio.com/scores/'
        token: 'GANGLERE_D16A'
        author: 'darkoverlordofdata'
        description: "Disguised as the adventurer Ganglere, you sneak into the walled city of Troy, fighting your way past Thor, Loke and Fenris to steal Odin's Treasure."
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
