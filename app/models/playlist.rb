class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks
  validates :name, presence: true
end