class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      if !column_exists?(:users, :reset_password_token)
        t.string :reset_password_token
        t.datetime :reset_password_sent_at
      end

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      ## Confirmable (opcjonalne)
      # if !column_exists?(:users, :confirmation_token)
      #   t.string :confirmation_token
      #   t.datetime :confirmed_at
      #   t.datetime :confirmation_sent_at
      #   t.string :unconfirmed_email # Only if using reconfirmable
      # end

      ## Lockable (opcjonalne)
      # if !column_exists?(:users, :unlock_token)
      #   t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      #   t.string :unlock_token # Only if unlock strategy is :email or :both
      #   t.datetime :locked_at
      # end
    end

    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    # add_index :users, :confirmation_token, unique: true
    # add_index :users, :unlock_token, unique: true
  end
end
