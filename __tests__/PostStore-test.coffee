pathToApp = '../components/coffee/public/app/'
jest.dontMock(pathToApp + 'stores/app-store')
jest.dontMock(pathToApp + 'constants/app-constants')
jest.dontMock('object-assign')

describe 'PostStore', ->
  AppConstants = require(pathToApp + 'constants/app-constants')
  AppDispatcher = {}
  PostStore = {}
  callback = {}

  actionAddPost = 
    source: 'VIEW_ACTION'
    action: 
      actionType: AppConstants.VIEW_CREATE_POST
      post: 
        _id: 'id1'
        id: 'p_8967987342'
        authorId: 'hhdflkhgfo'
        authorEmail: 'test@test'
        author: 'Test Named'
        date: '817 january 2015'
        title: 'Test'
        content: 'test'

  actionDeletePost =
    source: 'VIEW_ACTION'
    action:
      actionType: AppConstants.VIEW_DELETE_POST
      id: 'id1'

  beforeEach () ->
    AppDispatcher = require(pathToApp + 'dispatchers/app-dispatcher')
    PostStore = require(pathToApp + 'stores/app-store')
    callback = AppDispatcher.register.mock.calls[0][0]

  it 'registers a callback with the dispatcher', () ->
    expect(AppDispatcher.register.mock.calls.length).toBe(1)

  it 'should initialize with no posts', () ->
    posts = PostStore.getPosts()
    expect(posts).toEqual({})

  it 'creates a post', () ->
    callback(actionAddPost)
    posts = PostStore.getPosts()
    keys = Object.keys(posts)
    expect(keys.length).toBe(1)
    expect(posts[0].title).toEqual('Test')

  it 'creates a post then deletes it', () ->
    callback(actionAddPost)
    posts = PostStore.getPosts()
    expect(posts.length).toBe(1)
    callback(actionDeletePost)
    expect(posts.length).toBe(0)