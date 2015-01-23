AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
merge = require 'react/lib/merge'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

CHANGE_EVENT = 'change'

actionTypes = AppConstants

user = {}

_addUser = (userData) ->
  user = userData

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
  
  switch action.actionType
    when actionTypes.RECIEVE_USER then _addUser(payload.action.user)

  UserStore.emitChange()
  return true

module.exports = UserStore