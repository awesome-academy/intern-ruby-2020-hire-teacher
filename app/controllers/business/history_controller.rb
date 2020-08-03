class Business::HistoryController < BusinessController
  before_action :logged_in_user

  def show
    @event = Event.order_by_event params[:id]
  end
end
