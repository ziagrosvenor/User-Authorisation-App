React = require 'react'
Router = require 'react-router'
PostStore = require '../../stores/app-store'
UserStore = require '../../stores/user-store'
AppActions = require '../../actions/app-actions'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../../components/post-shared/post-item'
_ = require 'lodash'

getUserState = ->
  user: UserStore.getOtherUser()
  posts: PostStore.getOtherUsersPosts()

UserProfile = React.createClass
  mixins: [new StoreWatchMixin(getUserState), Router.State]

  componentDidMount: ->
    {id} = @getParams()
    AppActions.getOtherUsersData(id)

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

    <div className="postModule">
      {user}
      <div className='postList'>
        {posts}
      </div>  
    </div>

module.exports = UserProfile