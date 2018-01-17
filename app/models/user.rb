class User < ApplicationRecord

  before_save { self.email = email.downcase}

  validates :first_name, presence: true, length: { minimum: 2, maximum: 30}
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 10, maximum: 50}, format: { with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false}

end
