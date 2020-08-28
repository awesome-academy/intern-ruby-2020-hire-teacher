class Business::EventsController < BusinessController
  before_action :logged_in_user
  before_action :set_event, except: :create
  before_action :load_room, only: %i(create update)

  def show; end

  def edit; end

  def create
    @event_new = Event.new event_params
    if @event_new.save
      flash[:success] = t "controller.events.success_create"
      redirect_to business_room_path id: params[:event_new][:room_id],
        day: params[:event_new][:date_event]
    else
      flash[:error] = t "controller.events.error_create"
      render "business/rooms/show"
    end
  end

  def update
    if @event.update event_params
      flash[:success] = t "controller.events.success_update"
      redirect_to business_room_path @event.room_id
    else
      flash[:error] = t "controller.events.error_update"
      render "business/rooms/show"
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = t "controller.events.success_destroy"
      redirect_to business_room_path @event.room_id
    else
      redirect_to business_room_path @event.room_id
      flash[:error] = t "controller.events.error_destroy"
    end
  end

  private
  def set_event
    @event = Event.find_by id: params[:id]
    return if @event

    flash[:danger] = t "error_load_event"
    redirect_to business_home_path
  end

  def event_params
    params.require(:event_new).permit Event::EVENT_PARAMS
  end

  def load_room
    @room = Room.find_by id: params[:event_new][:room_id]
    @event_load = Event.by_room_id params[:event_new][:room_id]
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    @monday = DateTime.now - DateTime.now.cwday + Settings.one
    @monday = Date.parse(params[:event_new][:day]) if params[:event_new][:day].present?
  end
end
