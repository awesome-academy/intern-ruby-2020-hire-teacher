class Managers::RoomsController < ManagersController
  before_action :correct_manager
  before_action :load_room, except: %i(index create new)
  before_action :get_location, except: %i(index destroy)

  def index
    @rooms = current_user.rooms.includes(location: :country)
                         .page(params[:page]).per Settings.page.size
  end

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

  def show
    @events = @room.events.page(params[:page]).per Settings.page.size
  end

  def edit
    return if @images.present?

    @room.images.build
  end

  def update
    if @room.update room_params
      flash[:success] = t "managers.success.update_room", name: @room.name
      redirect_to managers_room_path @room
    else
      flash[:danger] = t "managers.danger.update_room"
      render :edit
    end
  end

  def destroy
    @status = @room.destroy ? Settings.status.pass : Settings.status.fail
    respond_to do |format|
      format.html{redirect_to managers_rooms_path}
      format.js
    end
  end

  private

  def room_params
    params.require(:room).permit Room::CREATE_ROOM_PARAMS
  end

  def get_location
    @locations = Location.pluck :name, :id
  end
end
