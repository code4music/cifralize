class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :uuid
      t.string :slug
      t.string :name
      t.string :visibility

      t.timestamps
    end
  end
end
