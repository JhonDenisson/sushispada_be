class Address < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(active: true) }

  validates :street, :number, :neighborhood, :city, presence: true
  validates :label, length: { maximum: 50 }, allow_blank: true

  def soft_delete!
    update(active: false)
  end

  def full_address
    parts = [ street, number, complement, neighborhood, city ].compact_blank
    parts.join(", ")
  end
end
