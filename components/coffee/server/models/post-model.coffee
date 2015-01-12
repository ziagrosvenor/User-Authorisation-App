module.exports = (Schema) ->
  # Define scheme for user
  PostSchema = new Schema
    userId:
      type: String
    title:
      type: String
    content:
      type: String
    timestamp: Number	 

  PostSchema