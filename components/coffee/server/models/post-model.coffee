module.exports = (Schema) ->
  # Define scheme for user
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

  PostSchema