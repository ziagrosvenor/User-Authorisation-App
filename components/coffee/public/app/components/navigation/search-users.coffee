React = require 'react'
React.initializeTouchEvents(true)
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()
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

  handleFocus: (e) ->
    e.target.getDOMNode().focus()
    
  render: ->
    <div>
      <div className="form-group search-bar">
        <label>Search Users</label>
        <input className="form-control" type="text" ref='searchField' onTouchStart={@handleFocus} onChange={@handleChange}/>
      </div>
    </div>


UserSearch = React.createClass
  render: ->
    <div>   
      <div className='search'>
        <SearchField users={@props.users} onIconClick={@handleClick}/>
      </div>
    </div>

module.exports = UserSearch