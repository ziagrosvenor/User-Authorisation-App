Dispatcher = require './dispatcher'
merge = require 'react/lib/merge'

AppDispatcher = merge Dispatcher.prototype,
  handleViewAction: (action) ->
    this.dispatch
      source: 'VIEW_ACTION'
      action: action
  handleServerAction: (action) ->
    this.dispatch
      source: 'SERVER_ACTION'
      action: action
      
module.exports = AppDispatcher