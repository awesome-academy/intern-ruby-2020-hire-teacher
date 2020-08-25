class Managers::RoomActivesController < ManagersController
  before_action :correct_manager, :load_room
  def update
    @state = @room.locked?
    if @room.update active: @state ? :opened : :locked
      respond_to :js
    else
      flash[:warning] = t "managers.warning.locking"
      redirect_to managers_rooms_path
    end
  end
end
