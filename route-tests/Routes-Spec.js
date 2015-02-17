var app, request, should;

should = require('should');

request = require('supertest');

app = require('./test-server');

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
  var user;
  user = request.agent(app);
  it('should respond with a 302 message, redirecting to /admin', function(done) {
    return user.post('/login').send({
      username: 'foo@foo.com',
      password: 'foobar'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
      res.status.should.equal(302);
      res.header['location'].should.equal('/admin');
      return done();
    });
  });
  return it('should respond with a 302 message, redirecting to /', function(done) {
    return user.post('/login').send({
      username: 'foo',
      password: 'bar'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
      res.status.should.equal(302);
      res.header['location'].should.equal('/');
      return done();
    });
  });
});

describe('Session', function() {
  var user;
  user = request.agent(app);
  before(function(done) {
    return user.post('/login').send({
      username: 'foo@foo.com',
      password: 'foobar'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
  return it('should respond with a 200 message', function(done) {
    return user.get('/admin').expect(200).end(function(err, res) {
      if (err) {
        throw err;
      }
      res.status.should.equal(200);
      return done();
    });
  });
});
