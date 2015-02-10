class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks
  validates :name, presence: true

  def is_visible_to?(requested_user)
    (private? && requested_user.id == user.id) || !private?
  end
end