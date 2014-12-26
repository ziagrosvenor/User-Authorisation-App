app = require './test-server'

should = require 'should'
request = require 'supertest'

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

	user1 = request.agent(app)

	it 'should respond with a 302 message, redirecting to /admin', (done) ->
		user1
		.post('/login')
		.send({username: 'zia', password: 'auth'})
		.end (err, res) ->
			if err
				throw err
			res.status.should.equal(302)
			res.header['location'].should.equal('/admin')
			done()
