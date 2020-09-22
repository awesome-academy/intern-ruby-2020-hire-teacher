class Business::RoomsController < BusinessController
  before_action :authenticate_user!
  before_action :load_room, :check_week_create_event, :load_report, :load_event, only: :show
  before_action :load_room_pagination, only: :index

  load_and_authorize_resource

  def index
    @search = Room.ransack(params[:q])
    @rooms = @search.result
                    .page(params[:page]).per Settings.pagination
    @countries = Country.pluck :name, :id
    return unless @search.location_country_id_eq

    @country = Country.find_by id: @search.location_country_id_eq
    location_country = @country&.locations || Location

    @locations = location_country.pluck :name, :id
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
    return if @room

    render :index
    flash.now[:error] = t "business.room.error_load_room"
  end

  def load_event
    @event_load = Event.by_room_id params[:id]
    return if @event_load

    flash[:error] = t "controller.room.error_load_event"
    redirect_to store_location
  end

  def load_report
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    return if @reports

    flash[:error] = t "controller.room.error_load_report"
    redirect_to store_location
  end
end
