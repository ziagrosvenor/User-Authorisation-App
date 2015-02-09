React = require 'react'
Nav = require './navigation/user-navigation'
Search = require './navigation/search-users'

Template = React.createClass
  render: ->
    <div>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template