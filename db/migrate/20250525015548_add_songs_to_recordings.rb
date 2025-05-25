class AddSongsToRecordings < ActiveRecord::Migration[7.0]
  def change
    add_reference :recordings, :song, null: true, foreign_key: true
  end
end
