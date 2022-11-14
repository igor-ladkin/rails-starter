module Content
  extend self

  def table_name_prefix
    "content_"
  end

  def build_user_feed(user)
    Feed.new user: user
  end

  def leave_comment(author, commentable, comment)
    commentable.comments.create author: author, text: comment
  end

  def leave_reaction(user, reactable, reaction)
    reactable.reactions.create user: user, kind: reaction
  end
end
