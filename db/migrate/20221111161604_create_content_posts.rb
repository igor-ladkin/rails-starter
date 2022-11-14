class CreateContentPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :content_posts do |t|
      t.belongs_to :author, null: false, foreign_key: {to_table: :accounts_users}
      t.string :title, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
