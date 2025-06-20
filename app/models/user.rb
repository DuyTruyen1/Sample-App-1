class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6, maximum: 72 }

  validate :email_must_not_have_consecutive_dots

  has_secure_password

  private

  def email_must_not_have_consecutive_dots
    if email.present? && email.match?(/\.\./)
      errors.add(:email, "cannot contain consecutive dots")
    end
  end
end
