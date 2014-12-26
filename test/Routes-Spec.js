var app, request, should;

app = require('./test-server');

should = require('should');

request = require('supertest');

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
  var user1;
  user1 = request.agent(app);
  return it('should respond with a 302 message, redirecting to /admin', function(done) {
    return user1.post('/login').send({
      username: 'zia',
      password: 'auth'
    }).end(function(err, res) {
      if (err) {
        throw err;
      }
      res.status.should.equal(302);
      res.header['location'].should.equal('/admin');
      return done();
    });
  });
});
