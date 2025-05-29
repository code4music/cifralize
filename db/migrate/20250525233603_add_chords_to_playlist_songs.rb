class AddChordsToPlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_songs, :chords, :text
    add_column :playlist_songs, :notes, :text
    add_column :playlist_songs, :key, :string
  end
end
