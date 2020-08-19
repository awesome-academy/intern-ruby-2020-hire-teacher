class Managers::HomesController < ManagersController
  before_action :correct_manager, only: :index

  def index
    @rooms = current_user.rooms.includes(location: :country)
                         .page(params[:page]).per Settings.page.size
  end
end
