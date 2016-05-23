class User < ActiveRecord::Base
  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false},
      format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }

  validates :password,
      presence: true,
      length: { minimum: 8 }
end
