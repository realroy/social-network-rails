class Onboardings::ConsentsController < OnboardingsController
  before_action :handle_consented

  def edit
  end

  def update
    current_user.update!(consent: true)

    redirect_to onboardings_path
  end

  private
  def consents_params
    params.require(:user).permit(:consent)
  end

  def handle_consented
    redirect_to onboardings_path if current_user.consent?
  end
end
