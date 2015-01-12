module.exports = (Post) ->
  # For timestamp
  time = new Date
  # For XML entity encoding.
  # Entities = require('html-entities').XmlEntities
  # entities = new Entities
  create: (req, res) ->
    post = new Post
      userId: req.body.userId
      title: req.body.title
      content: req.body.content
      timestamp: time.getTime()

    post.save (err) ->
      if err
        return console.error(err)
    console.log(post)
    res.send(post)

  read: (req, res) ->
    Post.find (err, posts) ->
  	  if err
  	  	return console.error(err)
  	  res.send(posts)