class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :order_id
      t.date :order_date
      t.date :ship_date
      t.string :customer_id
      t.string :state
      t.string :region
      t.string :product_id
      t.float :sales
      t.integer :quantity

      t.timestamps
    end
  end
end
