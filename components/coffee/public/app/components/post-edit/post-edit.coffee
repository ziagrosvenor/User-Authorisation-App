# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../post-shared/post-item'


PostEditForm = React.createClass
  getInitialState: ->
    title: this.props.data.title
    content: this.props.data.content

  handleSubmit: (e) ->
    e.preventDefault()

    title = this.refs.title.getDOMNode().value.trim()
    content = this.refs.content.getDOMNode().value.trim()

    if !title || !content
      return

    this.props.onFormSubmit
      userId: 'ldldlkd'
      title: title
      content: content

    this.refs.title.getDOMNode().value = ''
    this.refs.content.getDOMNode().value = ''

    return
  handleChange: (e) ->
    this.setProps this.props.data.title = e.target.value
  render: ->
    title = this.props.data.title
    content = this.props.data.content

    <form className='postForm form' onSubmit={this.handleSubmit}>
      <div className='form-group'>
        <input className='form-control' 
          type='text' 
          value={title}
          onChange={this.handleChange}
          ref='title'/>
      </div>
      <div className='form-group'>
        <textarea className='form-control' 
          value={content} 
          ref='content'/>
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
    console.log(post)
  render: ->
    <div className='postModule'>
      <h1>Edit!</h1>
      <PostEditForm 
        data={this.state.data}
        onFormSubmit={this.onEdit}
      />
    </div>

module.exports = PostEdit