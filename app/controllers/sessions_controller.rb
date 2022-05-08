class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %w[create destroy]
  before_action :redirect_if_authenticated?, except: [:destroy]

  def create
    if session_params[:provider_name] == 'facebook'
      handle_sign_in_with_facebook
    end
  end

  def new
  end

  def destroy
    current_access_token.destroy!
  end

  private

  def redirect_if_authenticated?
    redirect_to edit_onboardings_consents_path if authenticated?
  end

  def session_params
    params.require(:sessions)
          .permit(:provider_name, :token, :user_id, :expired_at, :name)
  end

  def handle_sign_in_with_facebook
    ActiveRecord::Base.transaction do
      user = User.where(facebook_user_id: session_params[:user_id]).first_or_create! do |resource|
        resource.password = SecureRandom.alphanumeric(16)
        resource.facebook_user_id = session_params[:user_id]
      end

      access_token = user.access_tokens.create!(data: session_params[:token],
                                                expired_at: Time.zone.at(session_params[:expired_at]))

      cookies.signed[:playqpid_access_token] = {
        value: access_token.data,
        expires: access_token.expired_at
      }
    end

    render json: { redirect_url: edit_onboardings_consents_path }
  end
end
