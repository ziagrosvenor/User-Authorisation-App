# @cjsx React.DOM
React = require 'react/addons'
AppActions = require '../../actions/app-actions'
PostStore = require('../../stores/app-store')
UserStore = require('../../stores/user-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
SearchUsers = require '../navigation/search-users'
UserLink = require '../navigation/user-link'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

getComponentState = ->
  searchUsersResult: UserStore.getSearchResult()

AppSearch = React.createClass
  mixins: [new StoreWatchMixin(getComponentState)]
  render: ->
    userList = @state.searchUsersResult.map (user, i) ->
      <UserLink user={user} key={i}/>

    <div>
      <div className='page-wrapper'>
        <ul className='searchList'>{userList}</ul>
      </div>
      <div className='search-view'>
        <SearchUsers/>
      </div>
    </div>

module.exports = AppSearch