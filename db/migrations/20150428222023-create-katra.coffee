"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Katras",
      queryInterface.sequelize.getSchema('Katra', true)
    ).then ->
      done()


  down: (queryInterface, Sequelize, down) ->
    queryInterface.dropTable "Katras"