class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true
  has_many :order_items, dependent: :destroy

  enum :status, %i[draft placed preparing out_for_delivery delivered cancelled]
  enum :delivery_type, %i[delivery pickup]
  enum :payment_method, %i[pix card cash]

  validates :subtotal_cents, :delivery_fee_cents, :discount_cents, :total_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :drafts, -> { where(status: :draft) }

  def snapshot_address!(address)
    self.delivery_street = address.street
    self.delivery_number = address.number
    self.delivery_complement = address.complement
    self.delivery_neighborhood = address.neighborhood
    self.delivery_city = address.city
    self.delivery_reference = address.reference
    self.address = address
  end
end
