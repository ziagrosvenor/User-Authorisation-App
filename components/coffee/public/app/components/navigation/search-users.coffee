React = require 'react'
Link = require('react-router-component').Link
IconClose = require '../icons/close-icon'
SocketUtils = require '../../web-api-utils/websocket-utils'
AppActions = require '../../actions/app-actions'

Search = React.createClass
  handleChange: (e) ->
    searchTerm = e.target.value
    if searchTerm isnt ''
      SocketUtils.getUsers(searchTerm)
    else
      AppActions.clearUsers()
  handleClick: ->
    @refs.searchField.getDOMNode().value = ''
    AppActions.clearUsers()
    @props.onIconClick()
  render: ->
    userList = @props.users.map (user, i) ->
      <Link href={'/user/' + user._id} key={i} className='search-item'>
        <img src='img/user-thumb.jpg' />
        <ul className='item-details'>
          <li>{user.firstName} {user.surname}</li>
          <li>Joined {user.timestamp}</li>
        </ul>     
      </Link>

    <div>
      <div className="form-group search-bar">
        <IconClose className="iconClose" onClick={@handleClick}/>
        <label>Search Users</label>
        <input className="form-control" type="text" ref='searchField' onChange={@handleChange}/>
        <ul className='searchList'>{userList}</ul>
      </div>
      
    </div>

module.exports = Search