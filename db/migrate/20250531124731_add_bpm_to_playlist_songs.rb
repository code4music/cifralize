class AddBpmToPlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_songs, :bpm, :integer
  end
end
