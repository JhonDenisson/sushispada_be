class Coupon < ApplicationRecord
  has_many :order_coupons, dependent: :destroy
  has_many :orders, through: :order_coupons

  enum :kind, { percent: 0, fixed: 1 }

  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :kind, presence: true
  validates :min_subtotal_cents, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
