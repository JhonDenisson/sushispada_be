class CreateDeliveryZones < ActiveRecord::Migration[8.1]
  def change
    create_table :delivery_zones do |t|
      t.string :neighborhood, null: false
      t.integer :fee_cents, default: 0, null: false
      t.integer :estimated_minutes
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :delivery_zones, :neighborhood, unique: true
    add_index :delivery_zones, :active
  end
end
