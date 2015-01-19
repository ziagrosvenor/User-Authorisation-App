React = require 'react'
Link = require('react-router-component').Link

Search = React.createClass
  getInitialState: ->
    users: []
  handleChange: (e) ->
    searchTerm = e.target.value
    users = []
    if @props.users
      @props.users.map (user, i) ->
        username = user.firstName + ' ' + user.surname
        if username.indexOf(searchTerm) > -1
          users.push(user)

    if @isMounted()
      @setState
        users: users
  render: ->
    userList = this.state.users.map (user, i) ->
      <div key={i}>
        <li>{user.firstName}</li>
        <Link href={'/user/' + user._id}>Visit User</Link>
      </div>

    <div>
      <input type="text" onChange={@handleChange}/>
      <ul>{userList}</ul>
    </div>

module.exports = Search