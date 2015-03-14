# @cjsx React.DOM
React = require 'react/addons'
R = require 'ramda'
classSet = React.addons.classSet
{Navigation} = require 'react-router'
AppActions = require '../../actions/app-actions'
PostStore = require('../../stores/app-store')
UserStore = require('../../stores/user-store')
StoreWatchMixin = require '../../mixins/store-watch-mixin'
Post = require '../post-shared/post-item'
Nav = require '../navigation/user-navigation'
Notifications = require '../navigation/user-activity'
SearchUsers = require '../navigation/search-users'
DeletePost = require '../post-shared/delete-post-btn'
EditPost = require '../post-shared/edit-btn'
{TextField, FlatButton, FloatingActionButton, Slider, DropDownMenu, DatePicker} = require "material-ui"

PostList = React.createClass
  render: ->
    posts = this.props.data.map (post, i) ->
      <Post data={post} key={i}> 
        <DeletePost id={post._id}/>
      </Post> 
    <div className='postList'>
      {posts}
    </div>

PostForm = React.createClass
  getInitialState: ->
    typeOfWork: 'none'
    workTimes: 'none'

  handleSubmit: (e) ->
    e.preventDefault()

    job =
      role: undefined
      description: undefined
      location: undefined
      details:
        employerName: undefined
        rating: undefined
        typeOfWork: undefined
        wage: undefined
        workTimes: undefined
        startDate: undefined
        endDate: undefined
  
    allKeys = R.flatten(R.append(R.keys(job.details), R.keys(job)))

    makeObject = (accObject, key, id, list) =>
      if key == 'role' or key == 'description' or key == 'location'
        accObject[key] = @refs[key].getDOMNode().childNodes[2].value.trim()

      if key == 'employerName'
        accObject['details'] = accObject['details'] || {}
        accObject['details'][key] = @refs[key].getDOMNode().childNodes[2].value.trim()

      if key == 'rating'
        accObject['details'][key] = @refs[key].getDOMNode().childNodes[5].value.trim()

      if key == 'startDate' or key == 'endDate'
        node = @refs[key].getDOMNode().querySelectorAll('.mui-text-field input')
        accObject['details'][key] = node[0].value

      if key == 'typeOfWork' or key == 'workTimes'
        accObject['details'][key] = @state[key]

      accObject 

    jobToSubmit = R.reduceIndexed(makeObject, {}, allKeys)

    for key in allKeys
      if key == 'role' or key == 'description' or key == 'location'
        if jobToSubmit[key] == "" then return

      else if key isnt "details" and jobToSubmit["details"][key] == "" then return
    
    @props.onPostSubmit(jobToSubmit)
    return

  handleFocus: (e) ->
    e.target.getDOMNode().focus()

  handleWorkTypeChange: (e, index, item) ->
    @setState(typeOfWork: item.text)

  handleWorkTimeChange: (e, index, item) ->
    @setState(workTimes: item.text)

  render: ->
    jobTypes = [
      { payload: '1', text: 'Manual Work' }
      { payload: '2', text: 'Office Work' }
      { payload: '3', text: 'Retail Work' }
      { payload: '4', text: 'Charity Work' }
      { payload: '5', text: 'Self Employed'}
      { payload: '6', text: 'Other' }
    ]

    times = [
      { payload: '1', text: 'Full Time' }
      { payload: '2', text: 'Part Time' }
      { payload: '2', text: 'No Contract'}
      { payload: '3', text: 'Voluntary' }
    ]

    <form onSubmit={this.handleSubmit}>
      <div>
        <TextField 
          hintText="What was your job role?"
          floatingLabelText="Job Role"
          ref="role"
        />
      </div>
      <div>
        <TextField 
          hintText="Describe the job"
          floatingLabelText="Job Description"
          ref="description"
        />
      </div>

      <div>
        <TextField 
          hintText="Add the job location"
          floatingLabelText="Location"
          ref="location"
        />
      </div>
      <div>
        <TextField 
          hintText="Name your post"
          floatingLabelText="Employer Name"
          ref="employerName"
        />
      </div>
      <div>
        <label>Rating</label>
        <Slider name="ratingSlider" ref="rating"/>
      </div>
      <div>
        <DropDownMenu
          menuItems={jobTypes}
          onChange={@handleWorkTypeChange}
        />
        <DropDownMenu
          menuItems={times}
          onChange={@handleWorkTimeChange}
        />
      </div>
      <div>
        <DatePicker
          floatingLabelText="Date employed from"
          hintText="When did you start?"
          mode="portrait"
          ref="startDate"
        />
      </div>
      <div>
        <DatePicker
          floatingLabelText="Date employed until"
          hintText="When did you leave?"
          mode="portrait"
          ref="endDate"
        />
      </div>
      <FlatButton
        type='submit'
        onTouchTap={@handleSubmit}
        value='Post'
      >
        Submit
      </FlatButton>
    </form>

getComponentState = ->
  posts: PostStore.getPosts()
  
PostModule = React.createClass
  mixins: [new StoreWatchMixin(getComponentState), Navigation]
  getInitialState: ->
    leaving: false

  handlePostSubmit: (post) ->
    AppActions.addPost(post)

  handleTap: ->
    @setState leaving: true
    
    setTimeout =>
      @transitionTo('/posts')
    , 250
    
  render: ->
    modal = classSet {
      "modal-leaving": @state.leaving
      "postModal": !@state.leaving
    }
    modalBg = classSet {
      "modal-bg-leaving": @state.leaving
      "modal-bg": !@state.leaving
    }
    
    <div>
      <div className={modal}>
        <div className="postAddForm">
          <PostForm onPostSubmit={this.handlePostSubmit} />
        </div>
      </div>
      <div className={modalBg} onTouchTap={@handleTap}></div>
    </div>

module.exports = PostModule