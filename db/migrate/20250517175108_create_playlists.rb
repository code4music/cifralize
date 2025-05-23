class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid
      t.string :slug
      t.string :name
      t.string :description
      t.boolean :verified
      t.string :visibility
      t.integer :position, default: 0
      t.integer :likes_count, default: 0
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
