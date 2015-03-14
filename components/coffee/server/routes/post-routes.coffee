module.exports = (Post, User) ->
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
      if err then return console.error(err)
      if !req.session
        return
      
      item =
        type: 'Post created'
        seen: false
        timestamp: time.getTime()

      User.update email: req.session.username,
        $push:
          activity: item
              
        (err, data) ->
          if err
            return console.error(err)
    
      return
    res.send(post)

  read: (req, res) ->
    Post.find authorEmail: req.session.username, (err, posts) ->
      if err
        return console.error(err)
      res.send(posts)
  update: (req, res) ->
    Post.findOneAndUpdate
      _id: req.body._id,
      req.body,
      upsert: false,
      (err, post) ->
        if err
          return console.error(err)
        res.send(post)
  delete: (req, res) ->
    Post.findByIdAndRemove req.body.id, (err, result) ->
      if err
        return console.error(err)
      res.send(result)