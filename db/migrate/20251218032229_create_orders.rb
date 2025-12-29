class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      # t.references :address, null: true, foreign_key: true

      t.integer :status, default: 0, null: false
      t.integer :delivery_type
      t.integer :payment_method

      t.integer :subtotal_cents, default: 0, null: false
      t.integer :delivery_fee_cents, default: 0, null: false
      t.integer :discount_cents, default: 0, null: false
      t.integer :total_cents, default: 0, null: false

      t.string :delivery_street
      t.string :delivery_number
      t.string :delivery_complement
      t.string :delivery_neighborhood
      t.string :delivery_city
      t.string :delivery_reference

      t.text :notes
      t.datetime :placed_at

      t.timestamps
    end

    add_index :orders, [ :user_id, :status ]
  end
end
