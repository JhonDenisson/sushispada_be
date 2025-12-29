class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_coupons, dependent: :destroy
  has_many :coupons, through: :order_coupons

  enum :status, { draft: 0, placed: 1, preparing: 2, out_for_delivery: 3, delivered: 4, cancelled: 5 }
  enum :delivery_type, { delivery: 0, pickup: 1 }
  enum :payment_method, { pix: 0, cash: 1, credit: 2, debit: 3 }

  validates :subtotal_cents, :delivery_fee_cents, :discount_cents, :total_cents, numericality: { greater_than_or_equal_to: 0 }
  validate :must_have_items, unless: :draft?

  scope :drafts, -> { where(status: :draft) }
  scope :status, ->(status) { where(status: status) }
  scope :delivery_type, ->(delivery_type) { where(delivery_type: delivery_type) }
  scope :payment_method, ->(payment_method) { where(payment_method: payment_method) }

  def snapshot_address!(address)
    self.delivery_street = address.street
    self.delivery_number = address.number
    self.delivery_complement = address.complement
    self.delivery_neighborhood = address.neighborhood
    self.delivery_city = address.city
    self.delivery_reference = address.reference
    self.address = address
  end

  def recalculate_totals!
    self.subtotal_cents = order_items.sum(:total_price_cents)
    self.total_cents = subtotal_cents + (delivery_fee_cents || 0) - (discount_cents || 0)
    save!
  end

  private

  def must_have_items
    return if order_items.exists?

    errors.add(:base, "Order must have at least one item")
  end
end
