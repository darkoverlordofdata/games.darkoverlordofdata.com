"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Players",
      queryInterface.sequelize.getSchema('Player', true)
    ).then ->
      done()


  down: (queryInterface, Sequelize, down) ->
    queryInterface.dropTable "Players"