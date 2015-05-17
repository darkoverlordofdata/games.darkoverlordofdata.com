"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Games",
      queryInterface.sequelize.getSchema('Game', true)
    ).then -> done()

  down: (queryInterface, Sequelize, done) ->
    queryInterface.dropTable "Games"