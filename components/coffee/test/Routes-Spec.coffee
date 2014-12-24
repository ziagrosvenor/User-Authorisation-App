app = require './test-server'

should = require 'should'
request = require 'supertest'
superagent = require 'superagent'

describe('Public route access', () ->
	it('should respond with a 200 message', (done) ->
		request(app)
		.get('/')
		.expect(200)
		.end (err, res) ->
			res.status.should.equal(200)
			done()
	)

	it('should respond with a 302 message', (done) ->
		request(app)
		.post('/login')
		.expect(302)
		.end (err, res) ->
			res.status.should.equal(302)
			res.header['location'].should.equal('/')
			done()
	)

	it('should respond with a 404 message', (done) ->
		request(app)
		.get('/kjdkdj')
		.expect(404)
		.end (err, res) ->
			res.status.should.equal(404)
			done()
	)
)

describe 'Protected routes', () ->

	user1 = superagent.agent()
	user2 = superagent.agent()

	before (done) ->
		user1.post('http://localhost:2999/login')
		.send(username: 'zia', password: 'auth')
		.end (err, res) ->
			if err
				throw err
		user2.post('http://localhost:2999/login')
		.send(username: 'foo', password: 'bar')
		.end (err, res) ->
			if err 
				throw err
			done()

	it 'should respond with a 200 message', (done) ->
		user1
		.get('http://localhost:2999/admin')
		.end (err, res) ->
			res.status.should.equal(200)
			done()

	it 'should respond with a 302 message', (done) ->
		user2
		.get('http://localhost:2999/admin')
		.end (err, res) ->
			res.status.should.equal(302)
			done()
