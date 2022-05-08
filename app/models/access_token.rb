class AccessToken < ApplicationRecord
  belongs_to :user

  validates :data, presence: true

  scope :active, -> { AccessToken.where('expired_at > ?', Time.now) }
  scope :expired, -> { AccessToken.where('expired_at < ?', Time.now) }
end
