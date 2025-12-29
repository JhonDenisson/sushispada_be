class User < ApplicationRecord
  has_secure_password
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum :role, { customer: 0,  admin: 1 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
