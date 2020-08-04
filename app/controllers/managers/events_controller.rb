class Managers::EventsController < ManagersController
  before_action :correct_manager

  def index
    @q = params[:option].present? ? Event.ransack("#{params[:option]}": params[:search]).result.join_multi_table : Event.user_room_join
    @events = @q.sort_by_date_event(:desc)
                .page(params[:page]).per Settings.page.size
  end
end
