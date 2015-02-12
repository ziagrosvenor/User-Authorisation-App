React = require 'react'
Router = require 'react-router'
_ = require 'lodash'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
PostStore = require '../../stores/app-store'
UserStore = require '../../stores/user-store'
AppActions = require '../../actions/app-actions'

Post = require '../../components/post-shared/post-item'
LikeBtn = require '../../components/post-shared/like-post-btn'

getUserState = ->
  user: UserStore.getOtherUser()
  userInSession: UserStore.getId()
  posts: PostStore.getOtherUsersPosts()

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

    if @state.posts and @state.userInSession
      posts = _.map @state.posts, (post, i) =>
        console.log post
        <Post data={post} key={i}>
          <LikeBtn authorId={post.authorId} postId={post.id} userInSessionId={@state.userInSession}/>
        </Post>
    else
      posts = <div>...</div>

    <div>
      <div className="postModule">
        <h2>{user}</h2>
        <div className='postList'>
          {posts}
        </div>
      </div>
    </div>

module.exports = UserProfile