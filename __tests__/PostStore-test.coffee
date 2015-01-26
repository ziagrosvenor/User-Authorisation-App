pathToApp = '../components/coffee/public/app/'
jest.dontMock(pathToApp + 'stores/app-store')
jest.dontMock(pathToApp + 'constants/app-constants')
jest.dontMock('react/lib/merge')
jest.dontMock('object-assign')
jest.dontMock('es6-promise')

describe 'PostStore', ->
  AppConstants = require(pathToApp + 'constants/app-constants')
  AppDispatcher = {}
  PostStore = {}
  callback = {}

  actionAddPost = 
    actionType: AppConstants.VIEW_CREATE_POST
    post: 
      id: 'p_8967987342'
      authorId: 'hhdflkhgfo'
      authorEmail: 'test@test'
      author: 'Test Named'
      date: '817 january 2015'
      title: 'Test'
      content: 'test'

  beforeEach () ->
    Dispatcher = require(pathToApp + 'dispatchers/dispatcher')
    AppDispatcher = require(pathToApp + 'dispatchers/app-dispatcher')
    PostStore = require(pathToApp + 'stores/app-store')
    callback = AppDispatcher.register.mock.calls[0][0]

  it 'registers a callback with the dispatcher', () ->
    expect(AppDispatcher.register.mock.calls.length).toBe(1)