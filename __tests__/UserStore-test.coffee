pathToApp = '../components/coffee/public/app/'
jest.dontMock(pathToApp + 'stores/user-store')
jest.dontMock(pathToApp + 'constants/app-constants')
jest.dontMock('object-assign')
jest.dontMock('lodash')

describe 'User Store', ->
  AppConstants = require(pathToApp + 'constants/app-constants')
  AppDispatcher = {}
  UserStore = {}
  callback = {}

  mockUser = 
    _id: 'id1'
    firstName: 'test'
    surname: 'testSurname'
    email: 'test@test.com'
    activity: []

  actionRecieveUser =
    source: 'SERVER_ACTION'
    action:
      actionType: AppConstants.RECIEVE_USER
      user: mockUser

  actionRecievePost = 
    source: 'SERVER_ACTION'
    action: 
      actionType: AppConstants.RECIEVE_CREATED_POST
      post: 
        _id: 'id1'
        id: 'p_0001'
        authorId: 'testid'
        authorEmail: 'test@test'
        author: 'test auth'
        date: '17 january 2015'
        title: 'test'
        content: 'test'

  actionActivitySeen =
    source: 'VIEW_ACTION'
    action: 
      actionType: AppConstants.ACTIVITY_SEEN

  beforeEach ->
    AppDispatcher = require(pathToApp + 'dispatchers/app-dispatcher')
    UserStore = require(pathToApp + 'stores/user-store')
    callback = AppDispatcher.register.mock.calls[0][0]

  it 'registers a callback with the dispatcher', ->
    expect(AppDispatcher.register.mock.calls.length).toBe(1)

  it 'intializes with no user', ->
    user = UserStore.getUser()
    expect(user).toEqual({})

  it 'adds a user to the store', ->
    callback(actionRecieveUser)
    user = UserStore.getUser()
    expect(user).toEqual(mockUser)

  it 'gets the users email', ->
    callback(actionRecieveUser)
    email = UserStore.getEmail()
    expect(email).toEqual(mockUser.email)

  it 'gets the users full name', ->
    callback(actionRecieveUser)
    fullname = UserStore.getFullName()
    expect(fullname).toEqual(mockUser.firstName + ' ' + mockUser.surname)

  it 'get the users id', ->
    callback(actionRecieveUser)
    id = UserStore.getId()
    expect(id).toEqual(mockUser._id)

  it 'checks for user activity array', ->
    callback(actionRecieveUser)
    user = UserStore.getUser()
    expect(user.activity).toEqual([])

  it 'adds an unseen activity', ->
    callback(actionRecieveUser)
    callback(actionRecievePost)
    user = UserStore.getUser()
    expect(user.activity[0].seen).toEqual(false)

  it 'marks an activity as seen', ->
    callback(actionRecieveUser)
    callback(actionRecievePost)
    user = UserStore.getUser()
    expect(user.activity[0].seen).toEqual(false)
    callback(actionActivitySeen)
    user = UserStore.getUser()
    expect(user.activity[0].seen).toEqual(true)