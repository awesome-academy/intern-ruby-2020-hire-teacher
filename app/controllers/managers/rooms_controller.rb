class Managers::RoomsController < ManagersController
  before_action :correct_manager
  before_action :load_room, only: %i(show edit update)
  before_action :get_location, except: :index

  def index; end

  def new
    @room = Room.new
    @room.images.build
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

  def show; end

  def edit
    return if @images

    @room.images.build
  end

  def update
    if @room.update room_params
      flash[:success] = t "managers.success.update_room"
      redirect_to managers_room_path(@room)
    else
      flash[:danger] = "managers.danger.update_room"
      render :edit
    end
  end

  private

  def room_params
    params.require(:room).permit Room::CREATE_ROOM_PARAMS
  end

  def load_room
    @room = Room.find_by id: params[:id]
    if @room
      @images = @room.images
    else
      flash[:warning] = t "managers.warning.show_room", id: params[:id]
      redirect_to managers_root_path
    end
  end

  def get_location
    @locations = Location.pluck :name, :id
  end
end
