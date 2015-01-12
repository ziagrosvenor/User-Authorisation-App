module.exports = function(Schema) {
  var PostSchema;
  PostSchema = new Schema({
    userId: {
      type: String
    },
    title: {
      type: String
    },
    content: {
      type: String
    },
    timestamp: Number
  });
  return PostSchema;
};
