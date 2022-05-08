class UserProfileInterest < ApplicationRecord
  belongs_to :interest, optional: false
  belongs_to :user_profile, optional: false

  accepts_nested_attributes_for :interest

  # scope :age_user_profile_interests, -> { includes(:interest).where(interest: { target: 'age' }) }
  # scope :gender_user_profile_interests, -> { includes(:interest).where(interests: { target: 'gender' }) }

  # belongs_to :age_interests, -> () { includes(:interests).where(interests: { target: 'age' }) }, class_name: 'Interest'

  # belongs_to :gender_interests, -> () { includes(:interests).where(interests: { target: 'gender' }) }, class_name: 'Interest'
end
