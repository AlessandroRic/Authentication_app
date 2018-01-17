class User < ApplicationRecord

  validates :first_name, presence: true, length: { minimum: 3, maximum: 20}
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20}
  validates :email, presence: true

end
