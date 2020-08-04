class Managers::EventsController < ManagersController
  before_action :correct_manager

  def index
    @events = Event.search_events(params[:search], params[:option])
                   .sort_by_date_event(:desc)
                   .page(params[:page]).per Settings.page.size
  end
end
