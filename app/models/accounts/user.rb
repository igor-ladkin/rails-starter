class Accounts::User < ApplicationRecord
  has_many :posts,
    class_name: "Content::Post",
    foreign_key: :author_id,
    inverse_of: :author,
    dependent: :nullify

  has_many :comments,
    class_name: "Content::Comment",
    foreign_key: :author_id,
    inverse_of: :author,
    dependent: :nullify

  has_many :reactions,
    class_name: "Content::Reaction",
    foreign_key: :user_id,
    inverse_of: :user,
    dependent: :nullify

  validates :name, presence: true
end
