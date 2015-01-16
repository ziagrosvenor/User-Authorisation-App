# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
Link = require('react-router-component').Link

DeletePost = React.createClass
  handleClick: () ->
    AppActions.deletePost(this.props.id)
  render: () ->
    <div className='btn' onClick={this.handleClick}>X</div>

UpdatePost = React.createClass
  render: () ->
    <Link href={'/edit-post/' + this.props.id} className='btn'>
      Edit
    </Link>

Post = React.createClass
  render: ->
    <div className="post">
      <h2>{this.props.data.title}</h2>
      <p>{this.props.data.content}</p>
      <DeletePost id={this.props.data._id}/>
      <UpdatePost id={this.props.data._id}/>
    </div>

module.exports = Post