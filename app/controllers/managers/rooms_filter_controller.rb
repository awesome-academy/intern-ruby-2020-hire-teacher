class Managers::RoomsFilterController < ManagersController
  def index
    @rooms = Room.by_name(params[:room_name])
                 .by_created_at(params[:search_day])
                 .by_active(params[:option])
                 .desc_created_at
                 .page(params[:page]).per Settings.page.size
    render "managers/rooms/index"
  end
end
