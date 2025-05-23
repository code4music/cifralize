class CreateRecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :recordings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid
      t.string :title
      t.string :description
      t.string :visibility
      t.integer :likes_count
      t.integer :views_count

      t.timestamps
    end
  end
end
