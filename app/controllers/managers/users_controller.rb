class Managers::UsersController < ManagersController
  before_action :employee, only: :update

  authorize_resource

  def index
    @q = User.ransack(params[:q])
    @q.sorts = "created_at desc" if @q.sorts.empty?
    @users = @q.result
               .includes(:group)
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
