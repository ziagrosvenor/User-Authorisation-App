React = require 'react'
React.initializeTouchEvents(true)
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()
SocketUtils = require '../../web-api-utils/websocket-utils'
AppActions = require '../../actions/app-actions'

IconClose = require '../icons/close-icon'
IconSearch = require '../icons/search-icon'
UserLink = require '../navigation/user-link'

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

  handleFocus: (e) ->
    e.target.getDOMNode().focus()
    
  render: ->
    userList = @props.users.map (user, i) ->
      <UserLink user={user} key={i}/>

    <div>
      <div className="form-group search-bar">
        <IconClose className="iconClose" onTouchTap={@handleCloseClick}/>
        <label>Search Users</label>
        <input className="form-control" type="text" ref='searchField' onTouchStart={@handleFocus} onChange={@handleChange}/>
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
    iconStyle =
      display: 'inline'
    dropdownClasses = React.addons.classSet
      'search': true
      'is-active': this.state.dropdown == true
      'is-hidden': this.state.dropdown == false
    iconClasses = React.addons.classSet
      'iconNav': true
    <div style={iconStyle}>
      <IconSearch className={iconClasses} onClick={this.handleClick} onTouchStart={this.handleClick}/>
      <div className={dropdownClasses}>
        <SearchField users={@props.users} onIconClick={@handleClick}/>
      </div>
    </div>

module.exports = UserSearch