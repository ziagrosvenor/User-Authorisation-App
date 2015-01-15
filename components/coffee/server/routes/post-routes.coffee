module.exports = (Post) ->
  # For timestamp
  time = new Date
  # For XML entity encoding. Preventing persisted XSS
  Entities = require('html-entities').XmlEntities
  entities = new Entities
  
  create: (req, res) ->
    data = req.body
    post = new Post
      userId: data.userId
      title: entities.encode(data.title)
      content: entities.encode(data.content)
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
  update: (req, res) ->
    Post.findOneAndUpdate _id: req.body._id, req.body, upsert: true, (err, post) ->
      if err
        return console.error(err)
      res.send(post)
  delete: (req, res) ->
    Post.findById req.body.id, (err, posts) ->
      if err
        return console.error(err)
      posts.remove (err, post) ->
        if err
          return handleError(err)
        console.log('deleted')
    return