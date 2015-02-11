React = require 'react'
Router = require 'react-router'
_ = require 'lodash'
StoreWatchMixin = require '../../mixins/store-watch-mixin'

PostStore = require '../../stores/app-store'
UserStore = require '../../stores/user-store'
AppActions = require '../../actions/app-actions'

Post = require '../../components/post-shared/post-item'
Nav = require '../navigation/user-navigation'
Notifications = require '../navigation/user-activity'
SearchUsers = require '../navigation/search-users'

getUserState = ->
  user: UserStore.getOtherUser()
  posts: PostStore.getOtherUsersPosts()
  currentUser: UserStore.getUser()
  searchUsersResult: UserStore.getSearchResult()

UserProfile = React.createClass
  mixins: [new StoreWatchMixin(getUserState), Router.State]

  render: ->
    if @state.user
      user = 
        <div>
          <h2>{@state.user.firstName} {@state.user.surname}</h2>
        </div>
    else
      user = <div>loading...</div>

    if @state.posts
      posts = _.map @state.posts, (post, i) ->
        <Post data={post} key={i}/>
    else
      posts = <div>...</div>

    <div>
      <Nav>
        <Notifications activity={@state.currentUser.activity}/>
        <SearchUsers users={@state.searchUsersResult}/>
      </Nav>
      <div className="postModule">
        <h2>{user}</h2>
        <div className='postList'>
          {posts}
        </div>  
      </div>
    </div>

module.exports = UserProfile