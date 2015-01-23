module.exports = function(Schema) {
  var PostSchema;
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
    }
  });
  return PostSchema;
};
