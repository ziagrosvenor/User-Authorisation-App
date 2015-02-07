# For XML entity encoding. Preventing persisted XSS
Entities = require('html-entities').XmlEntities
entities = new Entities
time = new Date

module.exports = (io, Posts, Users) ->
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

        Users.update _id: post.authorId,
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

    socket.on 'delete_post', (id) ->
      Posts.findByIdAndRemove id, (err, result) ->
        if err
          return console.error(err)
        socket.emit 'post_deleted'

    socket.on 'get_users', (searchPhrase) ->
      regex = new RegExp(searchPhrase, 'i')

      Users.find firstName: $regex: regex, (err, users) ->
        if err
          return console.error(err)

        socket.emit 'users_found', users

    socket.on 'get_other_users_data', (id) ->
      Users.findById id, (err, user) ->
        if err
          return console.error(err)
        socket.emit 'other_user_found', user

      Posts.find authorId: id, (err, posts) ->
        if err
          return console.error(err)
        socket.emit 'other_user_posts_found', posts