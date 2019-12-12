# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :r_token

  before_save :downcase_email
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 70 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :posts
  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end

    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    create_remember_token
    update(remember_token: User.digest(r_token))
  end

  def forget
    update(remember_token: nil)
  end

  # Returns true if the given token matches the digest.
  def authentic_token?(token)
    return false if remember_token.nil?

    BCrypt::Password.new(remember_token).is_password?(token)
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end

  def create_remember_token
    self.r_token = User.new_token
  end
end
