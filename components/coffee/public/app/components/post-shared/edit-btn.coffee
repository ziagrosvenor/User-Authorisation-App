# @cjsx React.DOM
React = require 'react'
Link = require('react-router').Link

EditPost = React.createClass
  render: ->
    <Link to='edit' params={{id: @props.id}} className='btn'>
      Edit
    </Link>

module.exports = EditPost