React = require 'react'
UserStore = require '../stores/user-store'
UsersStore = require '../stores/users-store'
StoreWatchMixin = require '../mixins/store-watch-mixin'
Nav = require './navigation/user-navigation'
Search = require './navigation/search-users'
Link = require('react-router-component').Link

getCurrentUser = ->
  currentUser: UserStore.getUser()

getAllUsers = ->
  otherUsers: UsersStore.getAllUsers()

Template = React.createClass
  mixins: [new StoreWatchMixin(getCurrentUser, getAllUsers)]
  render: ->
    <div>
      <Nav user={@state.currentUser} users={@state.otherUsers}/>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template