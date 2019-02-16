class ChangeBidsAmountType < ActiveRecord::Migration[5.2]
  def change
    change_column :bids, :amount, :decimal, precision: 8, scale: 2, null: false
  end
end
