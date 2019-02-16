# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :user_id, index: true, null: false
      t.string :name, null: false
      t.string :state, null: false, default: 'hidden'
      t.text :description

      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
