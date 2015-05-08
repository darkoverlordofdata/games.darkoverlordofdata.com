###

  Some orm like utilities for Firebase

  @see http://bish.nu/2014/exposing-firebase-as-ORM-in-nodejs/

###

_ = require("underscore")
Firebase = require("firebase")

###

  Initialize the db (acting as ORM):

  orm = require('./firebase-orm')

  db = orm('http://INSTANCE.firebaseio.com',
    process.env.FIREBASE_AUTH, [ 'posts', 'comments' ])

  @param fbPath
  @param auth
  @param types
  @returns {{data: {}}}

###
module.exports = (fbPath, auth, types) ->

  fbRoot = new Firebase(fbPath)
  db = data: {}
  data = db.data
  fbRoot.authWithCustomToken auth, (err) ->
    throw err if err

  types.forEach (type) ->
    data[type] = {}
    data[type].values = []
    data[type].ids = []
    data[type].cloud = fbRoot.child(type)
    data[type].cloud.on "child_added", (snap) ->
      remoteItem = snap.val()
      localIndex = data[type].values.length
      data[type].values[localIndex] = remoteItem
      data[type].ids[localIndex] = snap.key()
      return

    data[type].cloud.on "child_removed", (snap) ->
      localIds = data[type].ids
      localItemIndex = localIds.indexOf(snap.key())
      if ~localItemIndex
        data[type].values.splice localItemIndex, 1
        localIds.splice localItemIndex, 1
      return

    data[type].cloud.on "child_changed", (snap) ->
      remoteItem = snap.val()
      localIds = data[type].ids
      localItemIndex = localIds.indexOf(snap.key())
      data[type].values[localItemIndex] = remoteItem  if ~localItemIndex
      return

    return

  ###

    Use db.read to read back the full list of objects of a particular resource type:

    db.read 'posts', (e, posts) ->
      console.log(posts)

    @param type
    @param next

  ###
  db.read = (type, next) ->
    values = data[type].values
    next null, values.map((obj, i) ->
      id = data[type].ids[i]
      _.extend(_.clone(obj), id: id)

    )
    return

  ###

    Use db.create to create new objects of provided resource type:

    db.create 'posts',
      title: 'Title',
      body: 'Body'
    , (e, post) ->
      id = post.id
      console.log('created with id', id)

    @param type
    @param obj
    @param next

  ###
  db.create = (type, obj, next) ->
    ref = data[type].cloud.push(obj, (e) ->
      return next(e)  if e
      next(null, _.extend(_.clone(obj), id: ref.key()))
      return
    )
    return

  ###

    Use db.update to update a particular object:

    db.update 'posts', post.id,
      title: 'New title'
    , (e, post) ->
      console.log('updated', post)


    @param type
    @param id
    @param attributes
    @param next
    @returns {*}

  ###
  db.update = (type, id, attributes, next) ->
    info = getResource(data[type], id)
    ref = info.ref
    obj = info.obj
    return next(new Error("Resource not found in database")) unless obj
    _.extend(obj, _.omit(attributes, "id"))
    ref.set obj, (e) ->
      return next(e)  if e
      next(null, _.extend(_.clone(obj), id: id))
      return
    return

  ###

    Use db.delete to delete a particular object from database:

    db.delete 'posts', id, (e, post) ->
      console.log('deleted', post)

    @param type
    @param id
    @param next
    @returns {*}

  ###
  db.delete = (type, id, next) ->
    info = getResource(data[type], id)
    ref = info.ref
    obj = info.obj
    return next(new Error("Resource not found in database")) unless obj
    ref.remove (e) ->
      return next(e)  if e
      next(null, _.extend(_.clone(obj), id: id))
      return
    return

  ###

    private:
    getResource

    @param dataObj
    @param id
    @returns {*}

  ###
  getResource = (dataObj, id) ->
    index = dataObj.ids.indexOf(id)
    obj = dataObj.values[index]
    return {} unless obj
    ref: dataObj.cloud.child(id)
    obj: obj

  return db
