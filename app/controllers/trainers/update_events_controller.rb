class Trainers::UpdateEventsController < TrainersController
  before_action :correct_trainer, :load_event, only: :update

  def update
    if @event.activate!
      respond_to :js
    else
      flash[:warning] = t "trainers.warning.locking"
      redirect_to trainers_root_path
    end
  end
end
