class User < ApplicationRecord

  attr_accessor :remember_token

  before_save { self.email = email.downcase}

  validates :first_name, presence: true, length: { minimum: 2, maximum: 30}
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 10, maximum: 50}, format: { with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns a random toker
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Return a digest_token of a given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Remembers a user token in the database for persistent sessions

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
