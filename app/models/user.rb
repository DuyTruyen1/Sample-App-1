class User < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_NAME_REGEX = /\A[a-zA-Z\s\'\-]+\z/
  validates :name, presence: true,
                  length: { maximum: 50 },
                  format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                   length: { maximum: 255 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: true
def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  has_secure_password
  validates :password, presence: true,
                      length: { minimum: 6, maximum: 70 }
end
