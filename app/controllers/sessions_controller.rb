class SessionsController < ApplicationController
  before_action :user_is_authenticated, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if auth_service.by_email_and_password(**login_params)
      redirect_to(root_path, notice: 'Welcome')
    else
      redirect_to(login_path, alert: 'Invalid credentials')
    end
  end

  def destroy
    auth_service.logout!
    redirect_to login_path, notice: 'Signed out!'
  end

  private

  def user_is_authenticated
    redirect_to root_path if current_user.present?
  end

  def login_params
    extract_params :user, permit: [:email, :password]
  end
end
