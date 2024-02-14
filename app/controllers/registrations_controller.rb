class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auth_login_user @user

      puts "Does this shit work?"

      flash[:success] = "User #{@user.first_name} has been successfully signed up!"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    return params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
