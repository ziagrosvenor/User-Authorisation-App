React = require 'react'
Link = require('react-router-component').Link
IconClose = require '../icons/close-icon'

Search = React.createClass
  getInitialState: ->
    users: []
  handleChange: (e) ->
    searchTerm = e.target.value
    users = []
    if @props.users
      @props.users.map (user, i) ->
        username = user.firstName + ' ' + user.surname
        if username.indexOf(searchTerm) > -1 and searchTerm isnt ''
          users.push(user)

    if @isMounted()
      @setState
        users: users
  handleClick: ->
    @refs.searchField.getDOMNode().value = ''
    if @isMounted()
      @setState
        users: []
    @props.onIconClick()
  render: ->
    userList = this.state.users.map (user, i) ->
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