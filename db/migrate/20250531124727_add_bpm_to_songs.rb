class AddBpmToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :bpm, :integer
  end
end
