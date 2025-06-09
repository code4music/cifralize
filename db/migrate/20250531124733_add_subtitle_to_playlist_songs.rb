class AddSubtitleToPlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_songs, :subtitle, :string
  end
end
