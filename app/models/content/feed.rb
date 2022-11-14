class Content::Feed
  PAGE_SIZE = 12

  attr_accessor :user, :posts
  private :user=, :posts=

  def initialize(user:)
    self.user = user
    self.posts = Content::Post.recommended_for(user).recent.limit PAGE_SIZE
  end
end
