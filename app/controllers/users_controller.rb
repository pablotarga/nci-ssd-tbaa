class UsersController < RestrictAccessController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
    # apply prev attributes
    if flash[:register_params].present?
      @user.attributes = flash[:register_params]
      @user.valid?
    end
  end

  def create
    # set flag signup to active validations on the model
    register_params[:signup] = true
    @user = User.new(register_params)
    if @user.save
      redirect_to(root_path, notice: 'Welcome to the platform')
    else
      # store used attributes to load them up after redirection
      flash[:register_params] = register_params

      # redirect to form, with flash[:alert] containing the errors
      redirect_to(register_path, alert: @user.errors.full_messages)
    end
  end

  private

  def register_params
    @register_params ||= extract_params(:user, permit: [:name, :email, :password, :role])
  end
end
