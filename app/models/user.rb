class User < ApplicationRecord
  has_secure_password
  enum :role, %i[customer admin]

  validates :email, presence: true, uniqueness: true
end
