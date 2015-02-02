var Entities, entities, time;

Entities = require('html-entities').XmlEntities;

entities = new Entities;

time = new Date;

module.exports = function(io, Posts, Users) {
  return io.on('connection', function(socket) {
    socket.on('new_post', function(post) {
      post = new Posts({
        id: post.id,
        authorId: post.authorId,
        authorEmail: post.authorEmail,
        author: post.author,
        date: post.date,
        title: entities.encode(post.title),
        content: entities.encode(post.content)
      });
      return post.save(function(err) {
        var item;
        if (err) {
          return console.error(err);
        }
        item = {
          type: 'Post created',
          seen: false,
          timestamp: time.getTime()
        };
        Users.update({
          _id: post.authorId
        }, {
          $push: {
            activity: item
          }
        }, function(err, data) {
          if (err) {
            return console.error(err);
          }
        });
        return socket.emit('post_saved', post);
      });
    });
    socket.on('update_post', function(post) {
      return Posts.findOneAndUpdate({
        _id: post._id
      }, post, {
        upsert: false
      }, function(err, post) {
        if (err) {
          return console.error(err);
        }
        return socket.emit('post_updated', post);
      });
    });
    socket.on('delete_post', function(id) {
      return Posts.findByIdAndRemove(id, function(err, result) {
        if (err) {
          return console.error(err);
        }
        return socket.emit('post_deleted');
      });
    });
    return socket.on('get_users', function(searchPhrase) {
      var regex;
      regex = new RegExp(searchPhrase, 'i');
      return Users.find({
        firstName: {
          $regex: regex
        }
      }, function(err, users) {
        if (err) {
          return console.error(err);
        }
        return socket.emit('users_found', users);
      });
    });
  });
};
