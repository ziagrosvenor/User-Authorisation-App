server = require '../server'
app = require '../app'

should = require 'should'

supertest = require 'supertest'

describe('authAppRoutes', () ->
	it('should return 200 message for base URL', (done) ->
		supertest(app)
		.get('/')
		.expect(200)
		.end (err, res) ->
			res.status.should.equal(200);
			done()
	)
	it('should issue a redirect message', (done) ->
		supertest(app)
		.post('/login')
		.expect(302)
		.end (err, res) ->
			res.status.should.equal(302);
			done()
	)
	it('should issue a page not found message', (done) ->
		supertest(app)
		.get('/kjdkdj')
		.expect(404)
		.end (err, res) ->
			res.status.should.equal(404);
			done()
	)
)