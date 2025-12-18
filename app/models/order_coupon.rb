class OrderCoupon < ApplicationRecord
  belongs_to :order
  belongs_to :coupon
end
