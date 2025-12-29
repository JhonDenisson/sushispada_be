class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :label
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :reference
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :addresses, [ :user_id, :active ]
  end
end
