class Managers::EventsController < ManagersController
  before_action :correct_manager, :get_option

  def index
    @events = Event.search_events(params[:search], params[:option])
                   .page(params[:page]).per Settings.page.size
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_option
    @options = Settings.options.map{|key, val| [t(key.to_s), val]}
  end
end
