class AddPositionToPlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_songs, :position, :integer
  end
end
