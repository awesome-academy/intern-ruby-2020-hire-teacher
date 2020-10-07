class Managers::RoomActivesController < ManagersController
  before_action :correct_manager, :load_room

  skip_authorization_check

  def update
    @state = @room.locked?
    if @room.update active: @state ? :opened : :locked
      Sendmail.new.mail_to_booking_user @room
      respond_to :js
    else
      flash[:warning] = t "managers.warning.locking"
      redirect_to managers_rooms_path
    end
  end
end
