class Onboardings::BiosController < OnboardingsController
  def show
  end

  def update
    current_user.user_profile.update!(bio_params)

    redirect_to onboardings_personal_informations_path
  end

  private

  def bio_params
    params.require(:user_profile).permit(:bio)
  end
end
