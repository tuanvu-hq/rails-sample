class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_by(user_params)
      auth_login_user user

      flash[:success] = "You have signed in successfully."
      redirect_to dashboard_notes_path
    else
      flash[:alert] = "Invalid email or password."
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    auth_logout_user auth_get_current_user
    redirect_to root_path, notice: "You have been successfully logged out."
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
