AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
_ = require 'lodash'

CHANGE_EVENT = 'change'

actionTypes = AppConstants

user = {}

_addUser = (userData) ->
  user = userData

_userActivitySeen = ->
  user.activity = _.map user.activity, (activity) ->
    activity.seen = true
    return activity

_addActivity = (type) ->
  activity = _.map user.activity, (activityItem) ->
    return activityItem

  newActivity = 
    type: type
    seen: false
    timestamp: Date.now()

  activity.push(newActivity)

  user['activity'] = activity

UserStore = assign {}, EventEmitter.prototype,
  
  emitChange: ->
    this.emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    this.on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    this.removeListener(CHANGE_EVENT, callback)

  getUser: ->
    return user

  getId: ->
    return user._id

  getEmail: ->
    return user.email

  getFullName: ->
    return user.firstName + ' ' + user.surname

UserStore.dispatcherIndex = AppDispatcher.register (payload) ->
  action = payload.action
  console.log payload
  switch action.actionType
    when actionTypes.RECIEVE_USER then _addUser(payload.action.user)
    when actionTypes.ACTIVITY_SEEN then _userActivitySeen()
    when actionTypes.RECIEVE_CREATED_POST then _addActivity('post added')  

  UserStore.emitChange()
  return true

module.exports = UserStore