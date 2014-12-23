var app, server, should, supertest;

server = require('../server');

app = require('../app');

should = require('should');

supertest = require('supertest');

describe('authAppRoutes', function() {
  it('should return 200 message for base URL', function(done) {
    return supertest(app).get('/').expect(200).end(function(err, res) {
      res.status.should.equal(200);
      return done();
    });
  });
  it('should issue a redirect message', function(done) {
    return supertest(app).post('/login').expect(302).end(function(err, res) {
      res.status.should.equal(302);
      return done();
    });
  });
  return it('should issue a page not found message', function(done) {
    return supertest(app).get('/kjdkdj').expect(404).end(function(err, res) {
      res.status.should.equal(404);
      return done();
    });
  });
});
