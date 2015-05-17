"use strict"
module.exports = (sequelize, DataTypes) ->
  Katra = sequelize.define "Katra",
    sequelize.getSchema('Katra')
  ,
    classMethods:
      associate: (models) ->

  
  # associations can be defined here
  Katra