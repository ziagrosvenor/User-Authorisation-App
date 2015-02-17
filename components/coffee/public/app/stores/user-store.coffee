AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
_ = require 'lodash'

CHANGE_EVENT = 'change'

actionTypes = AppConstants

# Holds current logged in user
user = {}

# For storing information about a user who isn't in session
otherUser = {}

searchUsersResult = []

_updateSearchResult = (usersData) ->
  searchUsersResult = []
  _.forEach usersData, (user) ->
    searchUsersResult.push(user)

_clearUsers = ->
  searchUsersResult = []

_addUser = (userData) ->
  user = userData

_addOtherUser = (userData) ->
  otherUser = userData

_userActivitySeen = ->
  user.activity = _.map user.activity, (activity) ->
    activity.seen = true
    return activity

_addActivity = (activity) ->
  if user._id is activity.userId
    user.activity.push(activity)

UserStore = assign {}, EventEmitter.prototype,
  
  emitChange: ->
    this.emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    this.on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    this.removeListener(CHANGE_EVENT, callback)

  getUser: ->
    return user

  getSearchResult: ->
    return searchUsersResult

  getId: ->
    return user._id

  getEmail: ->
    return user.email

  getFullName: ->
    return user.firstName + ' ' + user.surname

  getOtherUser: ->
    return otherUser

  getOtherUsersId: ->
    return otherUser._id

UserStore.dispatcherIndex = AppDispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when actionTypes.RECIEVE_USER then _addUser(payload.action.user)
    when actionTypes.ACTIVITY_SEEN then _userActivitySeen()
    when actionTypes.RECIEVE_ALL_USERS then _updateSearchResult(payload.action.users)
    when actionTypes.CLEAR_USERS then _clearUsers()
    when actionTypes.RECIEVE_OTHER_USER then _addOtherUser(action.user)
    when actionTypes.RECIEVE_ACTIVITY_UPDATE then _addActivity(action.activity)


  UserStore.emitChange()
  return true

module.exports = UserStore