# @cjsx React.DOM
React = require 'react'
Link = require('react-router-component').Link

EditPost = React.createClass
  render: ->
    <Link href={'/edit-post/' + this.props.id} className='btn'>
      Edit
    </Link>

module.exports = EditPost