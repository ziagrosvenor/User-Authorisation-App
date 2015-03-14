# @cjsx React.DOM
React = require 'react'
Router = require 'react-router'
{FlatButton} = require 'material-ui'

# React.initializeTouchEvents(true)

EditPost = React.createClass
  mixins: [Router.Navigation, Router.State]
  handleTap: (e, item) ->
    @transitionTo('/edit-post/' + @props.id)
  render: ->
    <FlatButton onTouchTap={@handleTap} id='editBtn'>
      Edit
    </FlatButton>

module.exports = EditPost