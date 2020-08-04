class Managers::EventsController < ManagersController
  before_action :correct_manager

  def index
    @events = Event.page(params[:page]).per Settings.page.size
  end
end
