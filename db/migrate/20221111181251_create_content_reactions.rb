class CreateContentReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :content_reactions do |t|
      t.belongs_to :user, null: false, foreign_key: {to_table: :accounts_users}
      t.belongs_to :post, null: false, foreign_key: {to_table: :content_posts}
      t.string :kind, index: true

      t.timestamps
    end

    add_index :content_reactions, [:user_id, :post_id], unique: true
  end
end
