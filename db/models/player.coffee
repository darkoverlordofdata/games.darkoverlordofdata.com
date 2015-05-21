"use strict"
module.exports = (sequelize, DataTypes) ->
  Player = sequelize.define "Player",
    sequelize.getSchema('Player')
  ,
    classMethods:
      associate: (models) ->

  
  # associations can be defined here
  Player