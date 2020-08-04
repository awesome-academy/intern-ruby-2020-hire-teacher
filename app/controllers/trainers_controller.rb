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
end
