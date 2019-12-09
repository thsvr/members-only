class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 70 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # has_many :posts
  has_secure_password

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
