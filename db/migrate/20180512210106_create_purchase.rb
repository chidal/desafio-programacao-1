class CreatePurchase < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.string :purchaser_name
      t.string :item_description
      t.float :item_price
      t.integer :purchase_count
      t.text :merchant_address
      t.text :merchant_name

    end

  end

end
