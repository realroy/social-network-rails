class Onboardings::PersonalInformationsController < OnboardingsController
  def show
    user_profile_interests = current_user_profile.user_profile_interests
    @gender_user_profile_interest = user_profile_interests.includes(:interest).where(interest: { target: 'gender' }).first_or_initialize
    @gender_interest = @gender_user_profile_interest.interest || @gender_user_profile_interest.build_interest

    @age_user_profile_interest = user_profile_interests.includes(:interest).where(interest: { target: 'age' }).first_or_initialize
    @age_interest = @age_user_profile_interest.interest || @age_user_profile_interest.build_interest
  end

  def update
    ActiveRecord::Base.transaction do
      current_user_profile.gender_interests.destroy_all
      current_user_profile.age_interests.destroy_all
      current_user_profile.update!(personal_information_params)
    end
  end

  private

  def personal_information_params
    params.require(:user_profile)
          .except(:age)
          .permit(:name, :born_at, :gender, :height, :weight, user_profile_interests_attributes: {
            interest_attributes: [:target, :operator, :data]
          })
  end
end
