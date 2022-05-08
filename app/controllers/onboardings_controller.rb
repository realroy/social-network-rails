class OnboardingsController < ApplicationController
  before_action :user_authenticated!

  def show
    if current_user.user_profile.nil?
      UserProfile.create!(user: current_user)
    end
  end

end
