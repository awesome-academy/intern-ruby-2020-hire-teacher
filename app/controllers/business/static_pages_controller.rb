class Business::StaticPagesController < BusinessController
  before_action :logged_in_user
  before_action :load_room_pagination, only: :home

  def home
    @rooms = Room.page(params[:page]).per Settings.pagination
    @events = Event.order_by_event current_user.id
  end

  def about; end
end
