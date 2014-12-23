app = require '../server'

should = require 'should'

supertest = require 'supertest'

describe('authAppRoutes', () ->
	it('should return 200 message for base URL', (done) ->
		supertest(app)
		.get('/')
		.expect(200)
		.end (req, res) ->
			res.status.should.equal(200)
			.done()
	)
)