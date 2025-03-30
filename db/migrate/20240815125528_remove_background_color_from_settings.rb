class RemoveBackgroundColorFromSettings < ActiveRecord::Migration[7.1]
  def change
    remove_column :settings, :background_color, :string
  end
end
