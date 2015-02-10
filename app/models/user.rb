class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token, key_length: 24
  validates :email, presence: true
  has_many :playlists

  def valid_token?(token)
    auth_token == token
  end

  def public_profile
  end
end
