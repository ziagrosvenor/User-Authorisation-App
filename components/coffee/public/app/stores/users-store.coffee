AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
merge = require 'react/lib/merge'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'

CHANGE_EVENT = 'change'

actionTypes = AppConstants

users = []

_addUsers = (allUsersData) ->
  allUsersData.forEach (user) ->
    users.push(user)

UsersStore = assign {}, EventEmitter.prototype,
  
  emitChange: ->
    this.emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    this.on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    this.removeListener(CHANGE_EVENT, callback)

  getAllUsers: ->
    return users

UsersStore.dispatcherIndex = AppDispatcher.register (payload) ->
  action = payload.action
  
  switch action.actionType
    when actionTypes.RECIEVE_ALL_USERS then _addUsers(payload.action.users)

  UsersStore.emitChange()
  return true

module.exports = UsersStore