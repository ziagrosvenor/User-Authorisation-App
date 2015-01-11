Dispatcher = require './dispatcher'
merge = require 'react/lib/merge'

AppDispatcher = merge Dispatcher.prototype,
	handleViewAction: (action) ->
		console.log 'action', action
		this.dispatch
			source: 'VIEW_ACTION',
			action: action

module.exports = AppDispatcher;