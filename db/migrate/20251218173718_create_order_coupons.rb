class CreateOrderCoupons < ActiveRecord::Migration[8.1]
  def change
    create_table :order_coupons do |t|
      t.references :order, null: false, foreign_key: true
      t.references :coupon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
