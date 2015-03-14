AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
UserStore = require './user-store'
_ = require 'lodash'
assign = require 'object-assign'
EventEmitter = require('events').EventEmitter

CHANGE_EVENT = 'change'

posts = []
otherUsersPosts = []

_addPosts = (rawPosts) ->
  rawPosts.map (post, i) ->
    posts.push(post)

_addOtherUsersPosts = (rawPosts) ->
  otherUsersPosts = rawPosts

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

_addLike = (like) ->
  if UserStore.getOtherUsersId() is like.authorId
    otherUsersPosts.map (post, i) ->
      if like.postId == post.id
        otherUsersPosts[i]['likes'].push(like)
        
  if UserStore.getId() is like.authorId
    posts.map (post, i) ->
      if like.postId == post.id
        posts[i]['likes'].push(like)


PostStore = assign {}, EventEmitter.prototype,
  emitChange: ->
    this.emit(CHANGE_EVENT)
  addChangeListener: (callback) ->
    this.on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    this.removeListener(CHANGE_EVENT, callback)

  getNewPostData: (post) ->
    timestamp = Date.now()

    post['uid'] = 'p_' + timestamp

    post['meta'] =
      type: "job"
      dateAdded: new Date(timestamp)
      deleted: false

    post['author'] =
      id: UserStore.getId()
      email: UserStore.getEmail()
      name: UserStore.getFullName()

    post

  getPosts: ->
    return posts

  getPostById: (id) ->
    postToGet = {}

    posts.forEach (post) ->
      if post.id == id
        postToGet = post

    return postToGet

  getOtherUsersPosts: ->
    return otherUsersPosts

  dispatcherIndex: AppDispatcher.register (payload) ->
    action = payload.action

    switch action.actionType
      when AppConstants.RECIEVE_POSTS then _addPosts(action.posts)
      when AppConstants.VIEW_CREATE_POST then _addPost(action.post)
      when AppConstants.RECIEVE_CREATED_POST then _addPost(action.post)
      when AppConstants.VIEW_UPDATE_POST then _updatePost(action.post)
      when AppConstants.RECIEVE_UPDATED_POST then _updatePost(action.post)
      when AppConstants.VIEW_DELETE_POST then _deletePost(action.id)
      when AppConstants.RECIEVE_OTHER_USERS_POSTS then _addOtherUsersPosts(action.posts)
      when AppConstants.RECIEVE_POST_LIKES_UPDATE then _addLike(action.like)

    PostStore.emitChange()
    return true

module.exports = PostStore