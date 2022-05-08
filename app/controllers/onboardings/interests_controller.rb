class Onboardings::InterestsController < OnboardingsController
  def show
    @suggested_interests = Interest.suggest
    @lifestyle_interests = current_user_profile.lifestyle_interests
  end

  def update
    ActiveRecord::Base.transaction do
      current_user_profile.lifestyle_interests.destroy_all
      current_user_profile.update!(interests_params)
    end
  end

  def destroy
  end

  private

  def interests_params
    params.require(:user_profile).permit(user_profile_interests_attributes: {
      interest_attributes: [:target, :operator, :data]
    })
  end
end
