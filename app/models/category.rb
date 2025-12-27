class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :active, -> { where(active: true) }

  before_save :adjust_positions_on_collision

  private

  def adjust_positions_on_collision
    return unless position_changed? && position.present?

    candidates = Category.where("position >= ?", position)
                         .where.not(id: id)
                         .order(position: :asc)

    current_check_pos = position

    candidates.each do |candidate|
      if candidate.position <= current_check_pos
        current_check_pos += 1
        candidate.update_column(:position, current_check_pos)
      else
        break
      end
    end
  end
end
