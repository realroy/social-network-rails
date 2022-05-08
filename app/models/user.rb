class User < ApplicationRecord
  attribute :consent, default: false

  validates :consent, presence: true, on: :update

  has_many :access_tokens, dependent: :destroy
  has_one :user_profile, dependent: :destroy

  delegate_missing_to :user_profile
end
