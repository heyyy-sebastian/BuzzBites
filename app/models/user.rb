class User < ActiveRecord::Base
  has_secure_password

  validates :email,
      presence: true,
      uniqueness: {case_sensitive: false},
      uniqueness: true,
      format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }

  validates :password,
      presence: true,
      length: { minimum: 8 },
      format: { with: /[A-Za-z0-9._]/ }
end
