class Onboardings::ProfilePicturesController < OnboardingsController
  def show
  end

  def update
    current_user.user_profile.update!(profile_picture_params)
  end

  private

  def profile_picture_params
    params.require(:user).permit(:profile_picture)
  end
end
