# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :user_id, index: true, null: false
      t.integer :product_id, index: true, null: false
      t.integer :amount, precision: 8, scale: 2, null: false
      t.string  :state, null: false, default: 'pending'
      t.timestamps
    end
  end
end
