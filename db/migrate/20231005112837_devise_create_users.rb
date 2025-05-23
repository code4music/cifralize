# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.references :role
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :uuid
      t.string :slug

      # custom fields
      t.string :name
      t.string :phone
      t.string :zip
      t.string :address
      t.string :notes
      t.string :title
      t.string :office
      t.string :instagram
      t.string :linkedin
      t.string :website

      # device
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
  end
end
