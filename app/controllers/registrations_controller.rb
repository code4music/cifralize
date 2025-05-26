# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create, :update]

  def create
    @user = User.new(user_params)
    @user.role = Role.user

    if @user.save
      sign_in(@user)
      redirect_to(params[:redirect_to] || root_path)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :phone, :password, :password_confirmation)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
  end
end
