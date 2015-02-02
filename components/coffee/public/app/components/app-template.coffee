React = require 'react'
UserStore = require '../stores/user-store'
StoreWatchMixin = require '../mixins/store-watch-mixin'
Nav = require './navigation/user-navigation'
Search = require './navigation/search-users'
Link = require('react-router-component').Link

# return state to component in mixin
getCurrentUser = ->
  currentUser: UserStore.getUser()

getSearchResult = ->
  searchUsersResult: UserStore.getSearchResult()

Template = React.createClass
  mixins: [new StoreWatchMixin(getCurrentUser, getSearchResult)]
  render: ->
    <div>
      <Nav user={@state.currentUser} users={@state.searchUsersResult}/>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template