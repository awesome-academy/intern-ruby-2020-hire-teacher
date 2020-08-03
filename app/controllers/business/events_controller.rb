class Business::EventsController < BusinessController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :load_room, only: :create
  before_action :logged_in_user

  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def show; end

  def edit; end

  def create
    @event_new = Event.new event_params
    if @event_new.save
      flash[:success] = t "controller.events.success_create"
      redirect_to business_room_path params[:event_new][:room_id]
    else
      @event_new.errors.messages.each do |key, value|
        flash[:error] = [t(key), value].join(" : ")
      end
      render "business/rooms/show"
    end
  end

  def update
    if @event.update event_params
      flash[:success] = t "controller.events.success_update"
      redirect_to business_room_path @event.room_id
    else
      redirect_to business_room_path @event.room_id
      flash[:error] = t "controller.events.error_udpate"
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

    flash[:error] = t "error_load_event"
  end

  def event_params
    params.require(:event_new).permit(:title, :start_time, :end_time, :user_id, :room_id, :color, :description, :date_event)
  end

  def load_room
    @room = Room.find_by id: params[:event_new][:room_id]
    @event_load = @event_load = Event.where(room_id: params[:event_new][:room_id])
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    if params[:event_new][:day].present?
      @monday = Date.parse(params[:event_new][:day])
    else
      @monday = DateTime.now - DateTime.now.cwday + 1
    end
  end
end
