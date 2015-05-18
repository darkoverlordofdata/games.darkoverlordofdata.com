"use strict"
module.exports = (sequelize, DataTypes) ->

  Leaderboard = sequelize.define "Leaderboard",
    sequelize.getSchema('Leaderboard')
  ,
    classMethods:
      associate: (models) ->


# associations can be defined here
  Leaderboard