class Trainers::HomesController < TrainersController
  before_action :correct_trainer, only: :index

  def index
    @events = Event.user_room_join
                   .by_trainee(current_user.group_id)
                   .includes(:user)
                   .sort_by_date_event(:desc)
                   .page(params[:page]).per Settings.page.size
  end
end
