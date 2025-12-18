class DeliveryZone < ApplicationRecord
  scope :active, -> { where(active: true) }

  validates :neighborhood, presence: true, uniqueness: { case_sensitive: false }
  validates :fee_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :estimated_minutes, numericality: { greater_than: 0 }, allow_nil: true

  def self.find_by_neighborhood!(neighborhood)
    active.where("LOWER(neighborhood) = ?", neighborhood.downcase).first!
  end
end
