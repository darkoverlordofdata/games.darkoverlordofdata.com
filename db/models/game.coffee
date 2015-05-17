"use strict"
module.exports = (sequelize, DataTypes) ->

  Game = sequelize.define "Game",
    sequelize.getSchema('Game')
  ,
    classMethods:
      associate: (models) ->

  
  # associations can be defined here
  Game