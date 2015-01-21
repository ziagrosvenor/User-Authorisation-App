# @cjsx React.DOM
React = require 'react'
Link = require('react-router-component').Link

Post = React.createClass
  render: ->
    <div className="post">
      <h2>{this.props.data.title}</h2>
      <p>{this.props.data.content}</p>
      <div>
        {@props.children}
      </div>
    </div>

module.exports = Post