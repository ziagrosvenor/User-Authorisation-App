Dispatcher = require('flux').Dispatcher
assign = require('object-assign')

AppDispatcher = assign new Dispatcher(),
  handleViewAction: (action) ->
    this.dispatch
      source: 'VIEW_ACTION'
      action: action
  handleServerAction: (action) ->
    this.dispatch
      source: 'SERVER_ACTION'
      action: action
      
module.exports = AppDispatcher