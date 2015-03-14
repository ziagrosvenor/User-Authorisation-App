# @cjsx React.DOM
React = require 'react/addons'
{Navigation} = require 'react-router'
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
{TextField, FlatButton, FloatingActionButton, DropDownMenu, DatePicker} = require "material-ui"


PostList = React.createClass
  render: ->
    posts = this.props.data.map (post, i) ->
      <Post data={post} key={i}> 
        <DeletePost id={post._id}/>
      </Post> 
    <div className='postList'>
      {posts}
    </div>

PostForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()

    title = this.refs.title.getDOMNode().childNodes[2].value.trim()
    content = this.refs.content.getDOMNode().childNodes[2].value.trim()

    if !title || !content
      return

    this.props.onPostSubmit
      title: title
      content: content

    this.refs.title.getDOMNode().childNodes[2].value = ''
    this.refs.content.getDOMNode().childNodes[2].value = ''
    return

  handleFocus: (e) ->
    e.target.getDOMNode().focus()

  render: ->
    jobTypes = [
      { payload: '1', text: 'Manual Work' }
      { payload: '2', text: 'Office Work' }
      { payload: '3', text: 'Retail Work' }
      { payload: '4', text: 'Charity Work' }
      { payload: '5', text: 'Self Employed'}
      { payload: '6', text: 'Other' }
    ]

    times = [
      { payload: '1', text: 'Full Time' }
      { payload: '2', text: 'Part Time' }
      { payload: '2', text: 'No Contract'}
      { payload: '3', text: 'Voluntary' }
    ]

    <form onSubmit={this.handleSubmit}>
      <div className="form-group">
        <TextField 
          hintText="Name your post"
          floatingLabelText="Job Role"
          ref="title"
        />
      </div>
      <div className="form-group">
        <TextField 
          hintText="Name your post"
          floatingLabelText="Employer Name"
          ref="content"
        />
      </div>
      <div className="form-group">
        <DropDownMenu
          menuItems={jobTypes}
        />
        <DropDownMenu
          menuItems={times}
        />
      </div>
      <div className="form-group">
        <DatePicker
          floatingLabelText="Date employed from"
          hintText="When did you start?"
          mode="portrait"
        />
      </div>
      <FlatButton
        type='submit'
        onTouchTap={@handleSubmit}
        value='Post'
      >
        Submit
      </FlatButton>
    </form>

getComponentState = ->
  posts: PostStore.getPosts()
  
PostModule = React.createClass
  mixins: [new StoreWatchMixin(getComponentState), Navigation]
  handleAdd: (e) ->
    @transitionTo('/add')
  render: () ->
      <div className='home'>
        <div className="postModule">
          <PostList data={this.state.posts} />
          <FlatButton onTouchTap={@handleAdd}>Add a Job</FlatButton>
        </div>
      </div>

module.exports = PostModule

# <div className='form-group'>
#         <input className='form-control' 
#           type='text'
#           name='title'
#           onTouchStart={@handleFocus}
#           placeholder="What's New?"
#           ref='title'/>
#       </div>
#       <div className='form-group'>
#         <textarea className='form-control'
#           onTouchStart={@handleFocus}
#           name='content'
#           placeholder="Share something"
#           ref='content'/>
#       </div>