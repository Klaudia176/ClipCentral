class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :background_color
      t.string :font

      t.timestamps
    end
  end
end
