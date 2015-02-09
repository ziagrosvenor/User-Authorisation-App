React = require 'react'
Link = require('react-router').Link
SocketUtils = require '../../web-api-utils/websocket-utils'
AppActions = require '../../actions/app-actions'

IconClose = require '../icons/close-icon'
IconSearch = require '../icons/search-icon'

SearchField = React.createClass
  handleChange: (e) ->
    searchTerm = e.target.value
    if searchTerm isnt ''
      SocketUtils.getUsers(searchTerm)
    else
      AppActions.clearUsers()

  handleCloseClick: ->
    @refs.searchField.getDOMNode().value = ''
    AppActions.clearUsers()
    @props.onIconClick()
    
  render: ->
    userList = @props.users.map (user, i) ->
      <Link to='user' params={{id: user._id}} key={i} onClick={@handleCloseClick} className='search-item'>
        <img src='img/user-thumb.jpg' />
        <ul className='item-details'>
          <li>{user.firstName} {user.surname}</li>
          <li>Joined {user.timestamp}</li>
        </ul>     
      </Link>

    <div>
      <div className="form-group search-bar">
        <IconClose className="iconClose" onClick={@handleCloseClick}/>
        <label>Search Users</label>
        <input className="form-control" type="text" ref='searchField' onChange={@handleChange}/>
        <ul className='searchList'>{userList}</ul>
      </div>
    </div>


UserSearch = React.createClass
  getInitialState: ->
    dropdown: false

  handleClick: ->
    if @isMounted()
      @setState
        dropdown: !this.state.dropdown

  render: ->
    dropdownClasses = React.addons.classSet
      'search': true
      'is-active': this.state.dropdown == true
      'is-hidden': this.state.dropdown == false
    iconClasses = React.addons.classSet
      'iconNav': true
    <div>
      <IconSearch className={iconClasses} onClick={this.handleClick}/>
      <div className={dropdownClasses}>
        <SearchField users={@props.users} onIconClick={@handleClick}/>
      </div>
    </div>

module.exports = UserSearch