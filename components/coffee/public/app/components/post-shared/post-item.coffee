# @cjsx React.DOM
React = require 'react'
DeletePost = require './delete-post-btn'
EditPost = require './edit-btn'
Link = require('react-router-component').Link

Post = React.createClass
  render: ->
    <div className="post">
      <h2>{this.props.data.title}</h2>
      <p>{this.props.data.content}</p>
      <DeletePost id={this.props.data._id}/>
      <EditPost id={this.props.data._id}/>
    </div>

module.exports = Post