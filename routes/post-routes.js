module.exports = function(Post) {
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
        if (err) {
          return console.error(err);
        }
      });
      console.log(post);
      return res.send(post);
    },
    read: function(req, res) {
      return Post.find(function(err, posts) {
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
        upsert: true
      }, function(err, post) {
        if (err) {
          return console.error(err);
        }
        return res.send(post);
      });
    },
    "delete": function(req, res) {
      Post.findById(req.body.id, function(err, posts) {
        if (err) {
          return console.error(err);
        }
        return posts.remove(function(err, post) {
          if (err) {
            return handleError(err);
          }
          return console.log('deleted');
        });
      });
    }
  };
};
