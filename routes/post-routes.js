module.exports = function(Post, User) {
  var Entities, entities, time;
  time = new Date;
  Entities = require('html-entities').XmlEntities;
  entities = new Entities;
  return {
    create: function(req, res) {
      var data, post;
      data = req.body;
      post = new Post({
        userId: data.userId,
        title: entities.encode(data.title),
        content: entities.encode(data.content),
        timestamp: time.getTime()
      });
      post.save(function(err) {
        var item;
        if (err) {
          return console.error(err);
        }
        if (!req.session) {
          return;
        }
        item = {
          type: 'Post created',
          seen: false,
          timestamp: time.getTime()
        };
        User.update({
          email: req.session.username
        }, {
          $push: {
            activity: item
          }
        }, function(err, data) {
          if (err) {
            return console.error(err);
          }
        });
      });
      return res.send(post);
    },
    read: function(req, res) {
      return Post.find({
        authorEmail: req.session.username
      }, function(err, posts) {
        if (err) {
          return console.error(err);
        }
        return res.send(posts);
      });
    },
    update: function(req, res) {
      return Post.findOneAndUpdate({
        _id: req.body._id
      }, req.body, {
        upsert: false
      }, function(err, post) {
        if (err) {
          return console.error(err);
        }
        return res.send(post);
      });
    },
    "delete": function(req, res) {
      return Post.findByIdAndRemove(req.body.id, function(err, result) {
        if (err) {
          return console.error(err);
        }
        return res.send(result);
      });
    }
  };
};
