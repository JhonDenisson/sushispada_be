class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.reference :order, null: false, foreign_key: true
      t.reference :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :unit_price_cents, null: false
      t.integer :total_price_cents, null: false
      t.timestamps
    end
  end
end
