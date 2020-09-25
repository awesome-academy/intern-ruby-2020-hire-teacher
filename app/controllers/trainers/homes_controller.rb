class Trainers::HomesController < TrainersController
  before_action :correct_trainer, only: :index

  def index
    @events = Event.user_room_join
                   .with_deleted
                   .by_trainee(current_user.group_id)
                   .includes(:user)
                   .sort_by_date_event(:desc)
                   .page(params[:page]).per Settings.page.size
    @users = User.includes_group
                 .by_group(current_user.group_id)
                 .by_role(:trainee)
                 .sort_by_created_at(:desc)
                 .page(params[:page]).per Settings.page.size
  end
end
