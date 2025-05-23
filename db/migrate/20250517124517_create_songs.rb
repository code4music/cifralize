class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.references :genre, null: true, foreign_key: true
      t.string :uuid
      t.string :slug
      t.string :title
      t.text :chords
      t.string :status
      t.string :key
      t.string :composers
      t.boolean :verified
      t.string :visibility
      t.string :youtube_url
      t.string :spotify_url
      t.string :cifraclub_url
      t.boolean :from_cifraclub, default: false
      t.integer :likes_count, default: 0
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
