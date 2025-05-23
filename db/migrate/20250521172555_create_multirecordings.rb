class CreateMultirecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :multirecordings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
