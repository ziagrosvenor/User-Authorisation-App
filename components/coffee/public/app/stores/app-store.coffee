AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
UserStore = require './user-store'
assign = require 'object-assign'
EventEmitter = require('events').EventEmitter

CHANGE_EVENT = 'change'

posts = []

_addPosts = (rawPosts) ->
  rawPosts.map (post, i) ->
    posts.push(post)

_addPost = (newPost) ->
  if !newPost._id or posts.length is 0
    posts.push(newPost)
    return

  posts.map (post, i) ->
    if post.id == newPost.id
      posts[i] = newPost
    return

_updatePost = (updatedPost) ->
  posts.map (post, i) ->
    if post.id == updatedPost.id
      posts[i] = updatedPost

_deletePost = (id) ->
  posts.map (post, i) ->
    if post._id is id
      posts.splice(i, 1)
      return

PostStore = assign {}, EventEmitter.prototype,
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

  getPosts: ->
    return posts

  getPostById: (id) ->
    postToGet = {}

    posts.forEach (post) ->
      if post.id == id
        postToGet = post

    return postToGet

  dispatcherIndex: AppDispatcher.register (payload) ->
    action = payload.action
    
    switch action.actionType
      when AppConstants.RECIEVE_POSTS then _addPosts(action.posts)
      when AppConstants.VIEW_CREATE_POST then _addPost(action.post)
      when AppConstants.RECIEVE_CREATED_POST then _addPost(action.post)
      when AppConstants.VIEW_UPDATE_POST then _updatePost(action.post)
      when AppConstants.RECIEVE_UPDATED_POST then _updatePost(action.post)
      when AppConstants.VIEW_DELETE_POST then _deletePost(action.id)

    AppStore.emitChange()
    return true

module.exports = AppStore