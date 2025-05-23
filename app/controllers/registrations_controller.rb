# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :user_params, only: [:create]

  def create
    @user = User.new(user_params)
    @user.role = Role.usuario

    if @user.save
      sign_in(@user)
      if params[:redirect_to] == nil
        redirect_to root_path
      else
        redirect_to params[:redirect_to]
      end
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :phone, :password)
  end
end
