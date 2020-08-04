class Managers::UsersController < ManagersController
  before_action :correct_manager
  before_action :employee, only: :update

  def index
    @users = User.by_name(params[:name])
                 .by_email(params[:email])
                 .by_group(params[:group])
                 .by_role(params[:role])
                 .by_status(params[:status])
                 .desc_user_created_at
                 .page(params[:page]).per Settings.page.size
  end

  def update
    @status = !@user.activated?
    @user.update activated: @status

    respond_to :js
  end

  private

  def employee
    @user = User.find_by id: params[:id]
    return if none_manager? @user

    flash[:warning] = t "managers.warning.is_manager"
    redirect_to managers_users_path
  end
end
