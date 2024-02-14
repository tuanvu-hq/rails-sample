class User < ApplicationRecord
  has_secure_password

  has_many :notes, dependent: :destroy

  validates :first_name, presence: true, length: { in: 2..20 }
  validates :last_name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, length: { maximum: 30 }, uniqueness: true
  normalizes :email, with: -> (email) { email.strip.downcase }
  validates :password, presence: true, length: { in: 6..30 }
end
