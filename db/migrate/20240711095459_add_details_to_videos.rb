class AddDetailsToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :video_file, :string
    add_column :videos, :promoted, :boolean, default: false
  end
end

