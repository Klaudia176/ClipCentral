class AddReplyToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :reply, :text
  end
end
