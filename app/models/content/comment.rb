class Content::Comment < ApplicationRecord
  belongs_to :author, class_name: "Accounts::User"
  belongs_to :post

  validates :text, presence: true

  scope :recent, -> { order id: :desc }
end
