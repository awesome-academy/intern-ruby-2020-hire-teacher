class Managers::RoomsController < ManagersController
  before_action :correct_manager
  before_action :load_room, except: %i(index create new)
  before_action :get_location, except: %i(index destroy)

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
  debugger
    if @room.update room_params
      flash[:success] = t "managers.success.update_room", name: @room.name
      redirect_to managers_room_path @room
    else
      flash[:danger] = t "managers.danger.update_room"
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @room.destroy
        format.html{redirect_to managers_root_path, notice: t("managers.success.destroy_room", name: @room.name)}
        format.js
      else
        format.html
        format.json{render json: @room.errors, status: :unprocessable_entity}
      end
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
      return
    else
      flash[:danger] = t "managers.danger.update_room"
      render :edit
    end
  end

  def get_location
    @locations = Location.pluck :name, :id
  end
end
