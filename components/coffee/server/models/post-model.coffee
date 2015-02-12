module.exports = (Schema) ->
  Likes = new Schema
    userId: String
    postId: String
    authorId: String
    timestamp: Number
    date: Date
  # Define scheme for posts
  PostSchema = new Schema
    id:
      type: String
    authorId:
      type: String
    authorEmail:
      type: String
    author:
      type: String
    date:
      type: Date
    updated:
      type: Date
      default: Date.now
    title:
      type: String
    content:
      type: String
    likes: [Likes]

  PostSchema