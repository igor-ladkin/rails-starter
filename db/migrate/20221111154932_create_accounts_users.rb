class CreateAccountsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts_users do |t|
      t.string :name

      t.timestamps
    end
    add_index :accounts_users, :name, unique: true
  end
end
