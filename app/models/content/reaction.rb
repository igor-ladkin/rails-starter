class Content::Reaction < ApplicationRecord
  belongs_to :user, class_name: "Accounts::User"
  belongs_to :post

  validate :no_reacting_on_own_post

  enum kind: [:like, :dislike, :meh].index_with(&:itself)

  private

  def no_reacting_on_own_post
    if user_id == post.author_id
      errors.add :base, "can't react to own post"
    end
  end
end
