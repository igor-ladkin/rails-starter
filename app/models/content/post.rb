class Content::Post < ApplicationRecord
  belongs_to :author, class_name: "Accounts::User"

  has_many :reactions, class_name: "Content::Reaction", dependent: :destroy
  has_many :comments, class_name: "Content::Comment", dependent: :destroy
  has_many :top_recent_comments, -> { recent.limit(3) }, class_name: "Content::Comment"

  validates :title, presence: true
  validates :text, presence: true

  scope :recent, -> { order id: :desc }
  scope :recommended_for, ->(_user) { all }
end
