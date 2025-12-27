class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_coupons, dependent: :destroy
  has_many :coupons, through: :order_coupons

  enum :status, %i[draft placed preparing out_for_delivery delivered cancelled]
  enum :delivery_type, %i[delivery pickup]
  enum :payment_method, %i[pix cash credit debit]

  validates :subtotal_cents, :delivery_fee_cents, :discount_cents, :total_cents, numericality: { greater_than_or_equal_to: 0 }

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
end
