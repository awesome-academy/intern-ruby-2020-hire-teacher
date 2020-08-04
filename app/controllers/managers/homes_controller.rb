class Managers::HomesController < ManagersController
  before_action :correct_user, only: :index

  def index
    @rooms = @user.rooms
  end

  private

  def correct_user
    @user = User.get_manager
    return if @user && @user == current_user

    flash[:warning] = t "managers.warning.not_correct"
    redirect
end
