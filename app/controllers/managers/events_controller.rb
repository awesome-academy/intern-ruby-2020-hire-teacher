class Managers::EventsController < ManagersController
  authorize_resource

  def index
    option = params[:option]
    @q = option.present? ? Event.ransack("#{option}": params[:search]).result.join_multi_table : Event.user_room_join
    @events = @q.sort_by_date_event(:desc)
                .page(params[:page]).per Settings.page.size
  end
end
