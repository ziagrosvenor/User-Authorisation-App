# For XML entity encoding. Preventing persisted XSS
Entities = require('html-entities').XmlEntities
entities = new Entities
time = new Date

module.exports = (io, Posts, User) ->
  io.on 'connection', (socket) ->
    socket.on 'new_post', (post) ->
      post = new Posts
        id: post.id
        authorId: post.authorId
        authorEmail: post.authorEmail
        author: post.author
        date: post.date
        title: entities.encode(post.title)
        content: entities.encode(post.content)

      post.save (err) ->
        if err
          return console.error(err)
        
        item =
          type: 'Post created'
          seen: false
          timestamp: time.getTime()

        User.update _id: post.authorId,
          $push: 
            activity: item
                
          (err, data) ->
            if err
              return console.error(err)

        socket.emit 'post_saved', post

    socket.on 'update_post', (post) ->
      Posts.findOneAndUpdate _id: post._id, post, upsert: false, (err, post) ->
        if err
          return console.error(err)
        socket.emit 'post_updated', post