module AuthenticationConcern extend ActiveSupport::Concern
  included do
    helper_method :auth_get_current_user, :auth_is_user_signed_in?
  end

  private

  def auth_user_controll_point!
    redirect_to root_path, alert: "You must be logged in to do that." unless auth_is_user_signed_in?
  end

  def auth_get_current_user
    return Current.user ||= auth_get_user_from_session
  end

  def auth_get_user_from_session
    return User.find_by(id: session[:user_id])
  end

  def auth_is_user_signed_in?
    return auth_get_current_user.present?
  end

  # LOGIN / LOGOUT

  def auth_login_user(user)
    Current.user = user

    reset_session
    session[:user_id] = user.id
  end

  def auth_logout_user(user)
    Current.user = nil

    reset_session
  end
end
