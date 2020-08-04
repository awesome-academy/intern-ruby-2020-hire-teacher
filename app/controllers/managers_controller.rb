class ManagersController < ApplicationController
  layout "managers"

  check_authorization

  before_action :authenticate_user!

  include RoomsHelper
  include ManagersHelper

  rescue_from CanCan::AccessDenied do
    flash[:warning] = t "cancancan.warning.access_denied"
    redirect_to business_home_path
  end

  private

  def correct_manager
    return if current_manager

    flash[:warning] = t "managers.warning.not_correct"
    redirect_to business_home_path
  end

  def load_room
    @room = Room.find_by id: params[:id]
    @images = @room&.images
    return if @room.present?

    flash[:warning] = t "managers.warning.show_room", id: params[:id]
    redirect_to managers_rooms_path
  end

  def current_manager
    current_user if current_user&.manager?
  end

  def current_ability
    @current_ability ||= ManagerAbility.new(current_manager)
  end
end
