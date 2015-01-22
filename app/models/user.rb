class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token, key_length: 24
  validates :email, presence: true

  def valid_token?(token)
    auth_token == token
  end
end
