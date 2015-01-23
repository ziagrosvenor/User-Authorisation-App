# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Link = require('react-router-component').Link
Post = require '../post-shared/post-item'
DeletePost = require '../post-shared/delete-post-btn'
EditPost = require '../post-shared/edit-btn'
# AddPost = require '../components/app-updatepost'

PostList = React.createClass
  render: ->
    posts = this.props.data.map (post, i) ->
      <Post data={post} key={i}> 
        <DeletePost id={post._id}/>
        <EditPost id={post._id}/>
      </Post> 
    <div className='postList'>
      {posts}
    </div>

PostForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()

    title = this.refs.title.getDOMNode().value.trim()
    content = this.refs.content.getDOMNode().value.trim()

    if !title || !content
      return

    this.props.onPostSubmit
      title: title
      content: content

    this.refs.title.getDOMNode().value = ''
    this.refs.content.getDOMNode().value = ''
    return

  render: ->
    <form className='postForm form' onSubmit={this.handleSubmit}>
      <div className='form-group'>
        <input className='form-control' type='text' placeholder="What's New?" ref='title'/>
      </div>
      <div className='form-group'>
        <textarea className='form-control' placeholder="Share something" ref='content' />
      </div>
      <input className='btn' type='submit' value='Post'/>
    </form>

getPosts = ->
  posts: AppStore.getPosts()     
  
PostModule = React.createClass
  mixins: [new StoreWatchMixin(getPosts)]
  handlePostSubmit: (post) ->
    AppActions.addPost(post)
  render: () ->
    <div className="postModule">
      <h1>Posts!</h1>
      <PostForm onPostSubmit={this.handlePostSubmit} />
      <PostList data={this.state.posts} />
    </div>

module.exports = PostModule