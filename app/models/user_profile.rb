class UserProfile < ApplicationRecord

  GENDERS = {
    male: 'male',
    female: 'female'
  }

  belongs_to :user, dependent: :destroy
  has_one_attached :profile_picture

  attribute :born_at, default: -> { 20.years.ago }
  attribute :name, default: -> { "ID #{SecureRandom.alphanumeric(8)}" }
  # attribute :gender, default: -> { GENDERS[:male] }

  # validates :name, presence: true, on: :update
  # validates :gender, presence: true, inclusion: GENDERS.values, on: :update
  # validates :height, presence: true, numericality: { greater_than: 0 }, on: :update
  # validates :weight, presence: true, numericality: { greater_than: 0 }, on: :update

  validate :older_than_twenty?, on: :update

  enum gender: GENDERS

  has_many :user_profile_interests, dependent: :destroy
  has_many :interests, through: :user_profile_interests, dependent: :destroy

  accepts_nested_attributes_for :user_profile_interests

  delegate :gender_user_profile_interests, :age_user_profile_interests, to: :user_profile_interests

  has_many :age_interests,
           -> { includes(user_profile_interests: [:interest]).where(user_profile_interests: { interests: { target: 'age' } }) },
           through: :user_profile_interests, source: :interest

  has_many :gender_interests,
           -> { includes(user_profile_interests: [:interest]).where(user_profile_interests: { interests: { target: 'gender' } }) },
           through: :user_profile_interests, source: :interest

  has_many :lifestyle_interests,
           -> { includes(user_profile_interests: [:interest]).where.not(user_profile_interests: { interests: { target: ['gender', 'age'] } }) },
           through: :user_profile_interests, source: :interest

  def age
    now = DateTime.now
    age = now.year - born_at.year

    (age).year.ago > born_at ? age : age - 1
  end

  def older_than_twenty?
    errors.add(:age, 'must be greater than 20') unless 20.years.ago > born_at
  end

  def onboarding_completed?
    age_interests.any? && gender_interests.any? && GENDERS.has_key?(gender.to_sym)
  end
end
