class Business::EventsController < BusinessController
  before_action :logged_in_user
  before_action :set_event, except: :create
  before_action :load_room, only: %i(create update)

  def show; end

  def edit; end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = t "controller.events.success_create"
      @event.guests.each do |guest|
        UserMailer.invite_event(guest).deliver_now
        flash[:success] = t "controller.events.send_mail"
      end
      redirect_to business_room_path id: params[:event][:room_id],
        day: params[:event][:date_event]
    else
      flash[:error] = t "controller.events.error_create"
      render "business/rooms/show"
    end
  end

  def update
    if @event.update event_params
      flash[:success] = t "controller.events.success_update"
      redirect_to business_room_path id: params[:event][:room_id],
        day: params[:event][:date_event]
    else
      flash[:danger] = @event.errors.messages
      redirect_to business_room_path @event.room_id
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = t "controller.events.success_destroy"
      redirect_to business_room_path @event.room_id
    else
      redirect_to store_location
      flash[:danger] = @event.errors.messages
    end
  end

  private

  def set_event
    @event = Event.find_by id: params[:id]
    return if @event.present?

    flash[:danger] = t "error_load_event"
    redirect_to business_home_path
  end

  def event_params
    params.require(:event).permit Event::EVENT_PARAMS
  end

  def load_room
    @room = Room.find_by id: params[:event][:room_id]
    @event_load = Event.by_room_id params[:event][:room_id]
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    @users = User.all
    @monday = DateTime.now - DateTime.now.cwday + Settings.one
    @monday = Date.parse(params[:event][:day]) if params[:event][:day].present?
  end
end
