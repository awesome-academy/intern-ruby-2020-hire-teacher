class Business::EventsController < BusinessController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def show; end

  def edit; end

  def create
    @event_new = Event.new event_params
    if @event_new.save
      flash[:success] = t "success"
      redirect_to controller: "business/rooms", action: :show,
        id: params[:event_new][:room_id], day: params[:event_new][:date_event]
    else
      redirect_to business_room_path params[:event_new][:room_id]
      flash[:danger] = @event_new.errors.messages
    end
  end

  def update
    if @event.update event_params
      flash[:success] = t "success"
      redirect_to business_room_path @event.room_id
    else
      redirect_to business_room_path @event.room_id
      flash[:danger] = @event.errors.messages
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = t "success"
      redirect_to business_room_path @event.room_id
    else
      redirect_to business_room_path @event.room_id
      flash[:danger] = @event.errors.messages
    end
  end

  private
  def set_event
    @event = Event.find_by id: params[:id]
    return if @event

    flash[:danger] = t "error_load_event"
  end

  def event_params
    params.require(:event_new).permit Event::EVENT_PARAMS
  end
end
