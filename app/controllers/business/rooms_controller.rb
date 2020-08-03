class Business::RoomsController < BusinessController
  before_action :logged_in_user
  before_action :load_room, :check_week_create_event, :load_report, :load_event, only: :show
  before_action :load_room_pagination, only: :index
  before_action :logged_in_user

  def index
    @countries = Country.pluck :name, :id
    if params[:filter_country].present?
      @country = Country.find_by id: params[:filter_country]
      @locations = Location.pluck :name, :id unless @country

      @locations = @country.locations.pluck :name, :id
    end
    filter
  end

  def show
    @event = Event.new
    @event.guests.build
    @users = User.all
    if params[:status] == Settings.prev
      @monday = Date.parse(params[:day]) - Settings.week_day
    elsif params[:status] == Settings.next
      @monday = Date.parse(params[:day]) + Settings.week_day
    end
  end

  private

  def check_week_create_event
    @monday = if params[:day].present?
                Date.parse(params[:day]) - Date.parse(params[:day]).cwday + Settings.one
              else
                DateTime.now - DateTime.now.cwday + Settings.one
              end
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room.present?

    render :index
    flash.now[:danger] = t "business.room.error_load_room"
  end

  def load_event
    @event_load = Event.by_room_id params[:id]
    return if @event_load.present?

    flash[:error] = t "controller.room.error_load_event"
    redirect_to store_location
  end

  def load_report
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    return if @reports.present?

    flash[:error] = t "controller.room.error_load_report"
    redirect_to store_location
  end

  def filter
    @rooms = Room.by_name(params[:search_name])
                 .by_country(params[:filter_country])
                 .by_location(params[:filter_location])
                 .page(params[:page]).per Settings.pagination
  end
end
