class Business::UsersController < BusinessController
  before_action :load_user, :logged_in_user, except: %i(new create)
  before_action :correct_user, only: :show

  def show
    @role = @user.role
    @group = @user.group
  end

  def new
    @user = User.new
    @group = Group.pluck :name, :id
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controller.users.success_signup"
      log_in @user
      redirect_to business_home_path
    else
      flash[:danger] = t "controller.users.error_signup"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :role_id, :group_id
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "controller.users.load_user_error"
    redirect_to business_home_path
  end
end
