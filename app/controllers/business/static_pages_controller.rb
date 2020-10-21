class Business::StaticPagesController < BusinessController
  before_action :load_notification
  before_action :load_room_pagination, only: :home

  def home
    @rooms = Room.page(params[:page]).per Settings.pagination
  end

  def about; end
end
