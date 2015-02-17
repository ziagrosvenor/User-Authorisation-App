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
        if (err) {
          return console.error(err);
          (function(err, data) {
            if (err) {
              return console.error(err);
            }
          });
        }
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
    socket.on('get_users', function(searchPhrase) {
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
    socket.on('get_other_user', function(id) {
      console.log(id);
      Users.findById(id, function(err, user) {
        if (err) {
          return console.error(err);
        }
        return socket.emit('other_user_found', user);
      });
      return Posts.find({
        authorId: id
      }, function(err, posts) {
        if (err) {
          return console.error(err);
        }
        return socket.emit('other_user_posts_found', posts);
      });
    });
    return socket.on('post_liked', function(like) {
      var likeToPush, timestamp;
      timestamp = Date.now();
      likeToPush = {
        userId: like.userInSessionId,
        authorId: like.authorId,
        postId: like.postId,
        timestamp: timestamp,
        date: new Date(timestamp)
      };
      return Posts.update({
        authorId: like.authorId
      }, {
        $push: {
          likes: likeToPush
        }
      }, function(err, data) {
        var activityItem;
        if (err) {
          return console.error(err);
        }
        console.log(data);
        activityItem = {
          userId: like.authorId,
          type: 'Post liked',
          seen: false,
          timestamp: timestamp
        };
        io.emit('post_like_added', likeToPush);
        return Users.update({
          _id: like.authorId
        }, {
          $push: {
            activity: activityItem
          }
        }, function(err, data) {
          if (err) {
            return console.error(err);
          }
          console.log(data);
          return io.emit('activity_added', activityItem);
        });
      });
    });
  });
};
