class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }
  scope :category, ->(category_id) { where(category_id: category_id) }

end
