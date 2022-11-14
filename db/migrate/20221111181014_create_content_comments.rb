class CreateContentComments < ActiveRecord::Migration[7.0]
  def change
    create_table :content_comments do |t|
      t.belongs_to :author, null: false, foreign_key: {to_table: :accounts_users}
      t.belongs_to :post, null: false, foreign_key: {to_table: :content_posts}
      t.text :text

      t.timestamps
    end
  end
end
