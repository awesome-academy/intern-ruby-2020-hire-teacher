class Business::RoomsController < BusinessController
  before_action :load_room, only: :show
  before_action :load_room_pagination, only: :index

  def index
    @rooms = Room.page(params[:page]).per Settings.pagination
  end

  def show; end

  private

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room

    render :index
    flash.now[:danger] = t "business.room.error_load_room"
  end
end
