class Business::RoomsController < BusinessController
  before_action :load_room, :check_week_create_event, only: :show
  before_action :load_room_pagination, only: :index
  before_action :clear, :initialize_search, only: :index
  before_action :logged_in_user

  def index
    @countries = Country.pluck :name, :id
    if params[:filter_country].present?
      @country = Country.find_by id: params[:filter_country]
      if @country.nil?
        @locations = Location.pluck :name, :id
      end
      @locations = @country.locations.pluck :name, :id
    end
    handle_search_name
    handle_filters
  end

  def show
    @reports = @room.reports.page(params[:page]).per Settings.pagination_commit
    @event_new = Event.new
    @event_load = Event.where(room_id: params[:id])
    if params[:status] == "prev"
      @monday = Date.parse(params[:day]) - 7
    elsif params[:status] == "next"
      @monday = Date.parse(params[:day]) + 7
    end
  end

  private

  def check_week_create_event
    @monday = if params[:day].present?
                Date.parse(params[:day]) - Date.parse(params[:day]).cwday + 1
              else
                DateTime.now - DateTime.now.cwday + 1
              end
  end

  def clear
    session.delete :search_name
    session.delete :filter_country
    session.delete :filter_location
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room

    render :index
    flash.now[:danger] = t "business.room.error_load_room"
  end

  def initialize_search
    session[:search_name] ||= params[:search_name]
    session[:filter_country] = params[:filter_country]
    params[:filter_location] = nil if params[:filter_location] == ""
    session[:filter_location] = params[:filter_location]
  end

  def handle_search_name
    return unless session[:search_name]

    @rooms_filter = Room.by_name(session[:search_name])
    @rooms = @rooms_filter.page(params[:page]).per Settings.pagination
  end

  def handle_filters
    if session[:filter_country].present? && session[:filter_location].nil?
      @rooms = @country.rooms.page(params[:page]).per Settings.pagination
    elsif session[:filter_country] && session[:filter_location].present?
      @location = Location.find_by id: session[:filter_location]
      @rooms = @location.rooms.page(params[:page]).per Settings.pagination
    else
      @rooms
    end
  end
end
