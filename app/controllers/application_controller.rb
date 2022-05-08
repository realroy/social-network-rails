class UnauthorizedError < StandardError; end

class ApplicationController < ActionController::Base
  rescue_from UnauthorizedError, with: :render_unauthorized

  helper_method :authenticated?

  helper_method :current_user
  helper_method :current_user_profile

  def current_access_token
    data = cookies.signed[:playqpid_access_token]
    @access_token = AccessToken.includes(:user).find_by(data: data)
  end

  def current_user
    @current_user = current_access_token&.user
  end

  def current_user_profile
    @current_user&.user_profile
  end

  def user_authenticated!
    raise UnauthorizedError.new unless authenticated?
  end

  def authenticated?
    current_user.present?
  end

  private
  def render_unauthorized(e)
    redirect_to new_sessions_path, alert: 'Please sign in before proceed further'
  end
end
