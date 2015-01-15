AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
merge = require 'react/lib/merge'
EventEmitter = require('events').EventEmitter
_posts = require('../factory/app-factory')()

CHANGE_EVENT = 'change'

_addPost = (post) ->
	_posts.post(post)
	return

_updatePost = (post) ->
	_posts.update(post)
	return

_deletePost = (index) ->
	_posts.delete(index)
	return

AppStore = merge EventEmitter.prototype,
	emitChange: ->
		this.emit(CHANGE_EVENT)
	addChangeListener: (callback) ->
		this.on(CHANGE_EVENT, callback)
	removeChangeListener: (callback) ->
		this.removeListener(CHANGE_EVENT, callback)
	getPosts: () ->
		return _posts.get()
	dispatcherIndex: AppDispatcher.register (payload) ->
		action = payload.action

		switch action.actionType
			when AppConstants.ADD_POST then _addPost(payload.action.post)
			when AppConstants.UPDATE_POST then _updatePost(payload.action.post)
			when AppConstants.DELETE_POST then _deletePost(payload.action.index)

		AppStore.emitChange()
		return true

module.exports = AppStore