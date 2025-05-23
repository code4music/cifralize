class CreatePlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_songs do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.integer :transpose

      t.timestamps
    end
  end
end
