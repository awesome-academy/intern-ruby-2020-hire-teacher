class Managers::EventsController < ManagersController
  before_action :correct_manager

  def index
    @events = Event.search_events(params[:search], params[:option])
                   .desc_date_event
                   .page(params[:page]).per Settings.page.size
  end
end
