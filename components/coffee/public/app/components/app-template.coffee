React = require 'react'
Nav = require './navigation/user-navigation.coffee'
Search = require './navigation/search-users.coffee'
Link = require('react-router-component').Link

Template = React.createClass
  render: ->
    <div>
      <Nav user={@props.user}/>
      <Search users={@props.users}/>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template