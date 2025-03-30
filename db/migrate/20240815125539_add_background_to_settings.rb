class AddBackgroundToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :background, :string
  end
end
