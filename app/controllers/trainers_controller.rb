class TrainersController < ApplicationController
  layout "trainers"

  include RoomsHelper
  include ManagersHelper

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
    redirect_to managers_rooms_path
  end
end
