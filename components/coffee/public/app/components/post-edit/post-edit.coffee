# @cjsx React.DOM
React = require 'react'
Router = require 'react-router'
AppActions = require '../../actions/app-actions'
PostStore = require('../../stores/app-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../post-shared/post-item'

PostEditForm = React.createClass
  handleChange: (e) ->
    title = @refs.title.getDOMNode().value
    content = @refs.content.getDOMNode().value
    post = @props.data

    if title isnt '' 
      post['title'] = title

    if content isnt ''
      post['content'] = content

    @props.onFormChange(post)

  handleSubmit: (e) ->
    e.preventDefault()

    title = @refs.title.getDOMNode().value.trim()
    content = @refs.content.getDOMNode().value.trim()
    post = @props.data

    if !title and !content
      return

    if title
      post['title'] = title

    if content
      post['content'] = content

    post['updated'] = Date.now()

    @props.onFormSubmit(post)

    @refs.title.getDOMNode.value = ''
    @refs.content.getDOMNode.value = ''
    return

  render: ->
    <form className='postForm form' onSubmit={this.handleSubmit}  >
      <div className='form-group'>
        <input className='form-control'
          onChange={@handleChange} 
          type='text'
          ref='title'/>
      </div>
      <div className='form-group'>
        <textarea className='form-control' ref='content' onChange={@handleChange}/>
      </div>
      <input className='btn' type='submit' value='Update'/>
    </form>

getPost = (id) ->
  PostStore.getPostById(id)
      
PostEdit = React.createClass
  mixins: [Router.State]
  getInitialState: () ->
    {id} = @.getParams()
    post: getPost(id)

  componentWillMount: () ->
    PostStore.addChangeListener(this._onChange)

  componentWillUnmount: () ->
    PostStore.removeChangeListener(this._onChange) 

  _onChange: () ->
    {id} = @.getParams()
    @setState(getPost(id))

  onEdit: (post) ->
    if @isMounted()
      this.setState
        post: post
        
  onSubmit: (post) ->
    AppActions.updatePost(post)
        
  render: ->
    <div className='postModule'>
      <h1>Edit!</h1>
      <Post data={@state.post} />
      <PostEditForm
        data={@state.post}
        onFormChange={this.onEdit}
        onFormSubmit={this.onSubmit}
      />
    </div>

module.exports = PostEdit