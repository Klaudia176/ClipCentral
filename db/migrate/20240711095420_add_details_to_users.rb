class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :premium, :boolean, default: false
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    change_column :users, :role, :integer, default: 0

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
