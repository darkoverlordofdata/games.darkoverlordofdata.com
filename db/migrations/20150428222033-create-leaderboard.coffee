"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Leaderboards",
      queryInterface.sequelize.getSchema('Leaderboard', true)
    ).then -> done()

  down: (queryInterface, Sequelize, done) ->
    queryInterface.dropTable "Leaderboards"