class CreateCoupons < ActiveRecord::Migration[8.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :kind
      t.integer :value
      t.integer :min_subtotal_cents
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
