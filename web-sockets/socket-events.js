var Entities, entities, time;

Entities = require('html-entities').XmlEntities;

entities = new Entities;

time = new Date;

module.exports = function(io, Posts, User) {
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
        User.update({
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
    return socket.on('update_post', function(post) {
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
  });
};
