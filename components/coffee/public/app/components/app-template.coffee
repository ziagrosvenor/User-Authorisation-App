React = require 'react'
UserStore = require '../stores/user-store'
StoreWatchMixin = require '../mixins/store-watch-mixin'
Nav = require './navigation/user-navigation'
Search = require './navigation/search-users'
Link = require('react-router-component').Link

# return state to component in mixin
getComponentState = ->
  currentUser: UserStore.getUser()
  searchUsersResult: UserStore.getSearchResult()

Template = React.createClass
  getInitialState: ->
    getComponentState()

  componentWillMount: ->
    UserStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    UserStore.removeChangeListener(this._onChange)
         
  _onChange: ->
    @setState(getComponentState())

  render: ->
    <div>
      <Nav user={@state.currentUser} users={@state.searchUsersResult}/>
      <div>
        {this.props.children}
      </div>
    </div>

module.exports = Template