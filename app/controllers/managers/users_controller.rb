class Managers::UsersController < ManagersController
  before_action :correct_manager

  def index
    @users = User.desc_user_created_at
                 .page(params[:page]).per Settings.page.size
  end
end
