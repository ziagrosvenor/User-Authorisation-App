var app, request, should, superagent;

app = require('./test-server');

should = require('should');

request = require('supertest');

superagent = require('superagent');

describe('Public route access', function() {
  it('should respond with a 200 message', function(done) {
    return request(app).get('/').expect(200).end(function(err, res) {
      res.status.should.equal(200);
      return done();
    });
  });
  it('should respond with a 302 message', function(done) {
    return request(app).post('/login').expect(302).end(function(err, res) {
      res.status.should.equal(302);
      res.header['location'].should.equal('/');
      return done();
    });
  });
  return it('should respond with a 404 message', function(done) {
    return request(app).get('/kjdkdj').expect(404).end(function(err, res) {
      res.status.should.equal(404);
      return done();
    });
  });
});

describe('Protected routes', function() {
  var user1, user2;
  user1 = superagent.agent();
  user2 = superagent.agent();
  before(function(done) {
    user1.post('http://localhost:2999/login').send({
      username: 'zia',
      password: 'auth'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
    });
    return user2.post('http://localhost:2999/login').send({
      username: 'foo',
      password: 'bar'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
  it('should respond with a 200 message', function(done) {
    return user1.get('http://localhost:2999/admin').end(function(err, res) {
      res.status.should.equal(200);
      return done();
    });
  });
  return it('should respond with a 302 message', function(done) {
    return user2.get('http://localhost:2999/admin').end(function(err, res) {
      res.status.should.equal(302);
      return done();
    });
  });
});
