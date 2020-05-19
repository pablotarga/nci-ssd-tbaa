class ApplicationController < ActionController::Base
  private

  # contains rules to authenticate, store and remove user from the cookies
  def auth_service
    @auth_service ||= AuthService.new(request:request, cookies:cookies)
  end

  # check if current user is present otherwise send to login  page
  def authenticate_user!
    redirect_to login_path(), alert: "Restrict Content: Authentication required!" unless current_user.present?
  end

  # load current user from the cookie (encrypted, httponly)
  def current_user
    @current_user ||= User.find_by(id: cookies.encrypted[:user_id]) if cookies.encrypted[:user_id].present?
  end
  helper_method :current_user

  # encapsulate strong parameters allow fallback option and returning a hash with valid fields
  def extract_params base, permit: [], fallback: {}
    return fallback unless params.key?(base)

    params.require(base).permit(*permit).to_h.symbolize_keys
  end

  # pack/unpack methods to relieve session from storing parameters... store in the url using base64 but can be changed to use some sort of encryption
  def pack_params(params)
    {prev: Base64.urlsafe_encode64(params.to_json)}
  end

  def unpack_params
    JSON.parse(Base64.urlsafe_decode64(params[:prev])) rescue nil
  end

end
