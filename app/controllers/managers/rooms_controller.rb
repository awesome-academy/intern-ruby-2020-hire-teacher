class Managers::RoomsController < ManagersController
  before_action :correct_manager

  def index; end

  def new
    @room = Room.new
    @room.images.build
    @locations = Location.pluck :name, :id
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t "managers.success.create_room", name: @room.name
      redirect_to managers_room_path @room
    else
      flash[:danger] = t "managers.danger.create_room"
      render :new
    end
  end

  def show
    @room = Room.find_by id: params[:id]
    if @room
      @images = @room.images
    else
      flash[:warning] = t "managers.warning.show_room", id: params[:id]
      redirect_to managers_root_path
    end
  end

  private

  def room_params
    params.require(:room).permit Room::CREATE_ROOM_PARAMS
  end
end
