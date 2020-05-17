class ApplicationController < ActionController::Base
  private

  def auth_service
    @auth_service ||= AuthService.new(request:request, cookies:cookies)
  end

  def authenticate_user!
    redirect_to login_path(), notice: "Restrict Content: Authentication required!" unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.encrypted[:user_id]) if cookies.encrypted[:user_id].present?
  end
  helper_method :current_user

  def extract_params base, permit: [], fallback: {}
    return fallback unless params.key?(base)

    params.require(base).permit(*permit).to_h.symbolize_keys
  end
end
