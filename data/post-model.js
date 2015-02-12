module.exports = function(Schema) {
  var Likes, PostSchema;
  Likes = new Schema({
    userId: String,
    postId: String,
    authorId: String,
    timestamp: Number,
    date: Date
  });
  PostSchema = new Schema({
    id: {
      type: String
    },
    authorId: {
      type: String
    },
    authorEmail: {
      type: String
    },
    author: {
      type: String
    },
    date: {
      type: Date
    },
    updated: {
      type: Date,
      "default": Date.now
    },
    title: {
      type: String
    },
    content: {
      type: String
    },
    likes: [Likes]
  });
  return PostSchema;
};
