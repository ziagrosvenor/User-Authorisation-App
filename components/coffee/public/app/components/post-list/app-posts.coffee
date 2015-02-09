# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
PostStore = require('../../stores/app-store')
UserStore = require('../../stores/user-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../post-shared/post-item'
Nav = require '../navigation/user-navigation'
Notifications = require '../navigation/user-activity'
SearchUsers = require '../navigation/search-users'
DeletePost = require '../post-shared/delete-post-btn'
EditPost = require '../post-shared/edit-btn'

PostList = React.createClass
  render: ->
    posts = this.props.data.map (post, i) ->
      <Post data={post} key={i}> 
        <DeletePost id={post._id}/>
        <EditPost id={post.id}/>
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
        <input className='form-control' type='text' placeholder="What's New?" ref='title' />
      </div>
      <div className='form-group'>
        <textarea className='form-control' placeholder="Share something" ref='content' />
      </div>
      <input className='btn' type='submit' value='Post'/>
    </form>

getComponentState = ->
  posts: PostStore.getPosts()
  currentUser: UserStore.getUser()
  searchUsersResult: UserStore.getSearchResult()   
  
PostModule = React.createClass
  mixins: [new StoreWatchMixin(getComponentState)]
  handlePostSubmit: (post) ->
    AppActions.addPost(post)
  render: () ->
    <div>
      <Nav>
        <Notifications activity={@state.currentUser.activity}/>
        <SearchUsers users={@state.searchUsersResult}/>
      </Nav>
      <div className="postModule">
        <h1>Posts!</h1>
        <PostForm onPostSubmit={this.handlePostSubmit} />
        <PostList data={this.state.posts} />
      </div>
    </div>

module.exports = PostModule