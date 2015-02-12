# @cjsx React.DOM
React = require 'react/addons'
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
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

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

  handleFocus: (e) ->
    e.target.getDOMNode().focus()

  render: ->
    <form className='postForm form' onSubmit={this.handleSubmit}>
      <div className='form-group'>
        <input className='form-control' 
          type='text'
          onTouchStart={@handleFocus}
          placeholder="What's New?"
          ref='title'/>
      </div>
      <div className='form-group'>
        <textarea className='form-control'
          onTouchStart={@handleFocus}
          placeholder="Share something"
          ref='content'/>
      </div>
      <button className='btn'
        type='submit'
        onTouchTap={@handleSubmit}
        value='Post'>Submit</button>
    </form>

getComponentState = ->
  posts: PostStore.getPosts()
  
PostModule = React.createClass
  mixins: [new StoreWatchMixin(getComponentState)]
  handlePostSubmit: (post) ->
    AppActions.addPost(post)
  render: () ->
      <div className='home'>
        <div className="postModule">
          <h1>Posts!</h1>
          <PostForm onPostSubmit={this.handlePostSubmit} />
          <PostList data={this.state.posts} />
        </div>
      </div>

module.exports = PostModule