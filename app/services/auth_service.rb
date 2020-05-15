class AuthService < ApplicationService
  # attr_reader will generate getters for the instance variables request and user
  attr_reader :user

  # constructor receives the request as argument it is optional (required to extract current ip)
  def initialize(request:nil, cookies:nil)
    @request = request
    @cookies = cookies
    clear_user
  end

  # check if informed user is a user
  def by_user(user)
    clear_user
    return unless user.is_a?(User)

    @user = user
    update_current_access_info
    set_cookie
    true
  end

  # authenticate user by email and password
  def by_email_and_password(email, password)
    clear_user
    return false unless email.present? && password.present?

    user = User.find_by(email: email)
    return false unless user.present?
    return false unless user.authenticate(password)

    by_user(user)
  end

  private

  def clear_user
    @user = nil
  end

  def update_current_access_info
    user.update_attributes({
      last_access_at: user.current_access_at,
      last_access_ip: user.current_access_ip,
      current_access_at: Time.now,
      current_access_ip: (@request && (@request.env['HTTP_X_FORWARDED_FOR'] || @request.remote_ip))
    })
  end

  def set_cookie
    return unless @cookies.present?

    @cookies.encrypted[:user_id] = {
      value: user.id.to_s,
      expires: 1.year,
      httponly: true # hide from javascript
    }
  end
end
