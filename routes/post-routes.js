module.exports = function(Post) {
  var time;
  time = new Date;
  return {
    create: function(req, res) {
      var post;
      post = new Post({
        userId: req.body.userId,
        title: req.body.title,
        content: req.body.content,
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
    }
  };
};
