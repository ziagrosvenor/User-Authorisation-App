AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
UserStore = require './user-store'
merge = require 'react/lib/merge'
EventEmitter = require('events').EventEmitter
_posts = require '../factory/app-factory'
_users = require('../factory/users-factory')()

CHANGE_EVENT = 'change'

posts = []

_addPosts = (rawPosts) ->
	rawPosts.map (post, i) ->
		posts.push(post)

_addPost = (newPost) ->
	if !newPost._id
		posts.push(newPost)
		return
	posts.map (post, i) ->
		if post.id == newPost.id
			posts[i] = newPost
		return

_updatePost = (post) ->
	_posts.update(post)
	return

_deletePost = (id) ->
	_posts.delete(id)
	return

AppStore = merge EventEmitter.prototype,
	emitChange: ->
		this.emit(CHANGE_EVENT)
	addChangeListener: (callback) ->
		this.on(CHANGE_EVENT, callback)
	removeChangeListener: (callback) ->
		this.removeListener(CHANGE_EVENT, callback)
	getNewPostData: (post) ->
		timestamp = Date.now()
		id: 'p_' + timestamp
		authorId: UserStore.getId()
		authorEmail: UserStore.getEmail()
		author: UserStore.getFullName()
		date: new Date(timestamp)
		title: post.title
		content: post.content

	getPosts: () ->
		return posts
	getUsers: () ->
		_users.get()		
	dispatcherIndex: AppDispatcher.register (payload) ->
		action = payload.action

		switch action.actionType
			when AppConstants.CREATE_POST then _addPost(payload.action.post)
			when AppConstants.RECIEVE_POST then _addPost(payload.action.post)
			when AppConstants.UPDATE_POST then _updatePost(payload.action.post)
			when AppConstants.DELETE_POST then _deletePost(payload.action.id)
			when AppConstants.RECIEVE_POSTS then _addPosts(payload.action.posts)	

		AppStore.emitChange()
		return true

module.exports = AppStore