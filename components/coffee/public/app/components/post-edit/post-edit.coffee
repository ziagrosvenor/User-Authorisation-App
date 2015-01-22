# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../post-shared/post-item'

PostEditForm = React.createClass
  handleChange: (e) ->
    title = this.refs.title.getDOMNode().value
    content = this.refs.content.getDOMNode().value

    if title == '' 
      title = @props.data.title
    if content == ''
      content = @props.data.content

    this.props.onFormChange
      _id: @props.data._id
      userId: 'ldldlkd'
      title: title
      content: content
      timestamp: @props.data.timestamp
    return

  handleSubmit: (e) ->
    e.preventDefault()

    title = @refs.title.getDOMNode().value.trim()
    content = @refs.content.getDOMNode().value.trim()

    if !title and !content
      return

    if !title
      title = @props.data.title

    if !content
      content = @props.data.content 

    @props.onFormSubmit
      _id: @props.data._id
      userId: 'ldldlkd'
      title: title
      content: content
      timestamp: @props.data.timestamp

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

getPost = ->
  AppStore.getPosts().then (result) =>
    for obj in result
      if obj._id == this.props.id
        data = obj

    this.setState
      data: data
      
PostEdit = React.createClass
  mixins: [new StoreWatchMixin(getPost)]
  onEdit: (post) ->
    if @isMounted()
      this.setState
        data: post
  onSubmit: (post) ->
    AppActions.updatePost(post)
  render: ->
    <div className='postModule'>
      <h1>Edit!</h1>
      <Post data={this.state.data} />
      <PostEditForm
        data={this.state.data}
        onFormChange={this.onEdit}
        onFormSubmit={this.onSubmit}
      />
    </div>

module.exports = PostEdit