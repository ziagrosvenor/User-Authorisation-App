var app, should, supertest;

app = require('../server');

should = require('should');

supertest = require('supertest');

describe('authAppRoutes', function() {
  return it('should return 200 message for base URL', function(done) {
    return supertest(app).get('/').expect(200).end(function(req, res) {
      return res.status.should.equal(200).done();
    });
  });
});
