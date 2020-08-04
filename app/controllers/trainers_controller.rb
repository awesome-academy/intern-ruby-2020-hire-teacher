class TrainersController < ApplicationController
  layout "trainers"

  include RoomsHelper
  include ManagersHelper

  before_action :authenticate_user!

  private

  def correct_trainer
    return if current_user&.trainer?

    flash[:warning] = t "trainers.warning.not_correct"
    redirect_to business_home_path
  end

  def load_event
    @event = Event.find_by id: params[:id]
    return if @event

    flash[:warning] = t "managers.warning.show_room", id: params[:id]
    redirect_to trainers_root_path
  end
end
