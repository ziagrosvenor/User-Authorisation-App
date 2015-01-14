React = require 'react'
Nav = require './navigation/user-navigation.coffee'

Template = React.createClass
  render: ->
    <div>
      <Nav/>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template