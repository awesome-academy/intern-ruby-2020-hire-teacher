class Business::EventsController < BusinessController
  before_action :set_event, only: %i(show edit destroy)
  before_action :logged_in_user

  def index; end

  def new
    @event = Event.new
  end

  def create; end

  def show; end

  def edit; end

  def update; end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.find id: params[:id]
    return if @event

    flash[:danger] = t "not_find_event"
  end
end
