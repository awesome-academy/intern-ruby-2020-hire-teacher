class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "controller.application.logged_in"
    redirect_to login_url
  end

  def correct_manager
    return if current_user&.manager?

    flash[:warning] = t "managers.warning.not_correct"
    redirect_to business_home_path
  end

  def load_room
    @room = Room.find_by id: params[:id]
    if @room
      @images = @room.images
      return
    else
      flash[:warning] = t "managers.warning.show_room", id: params[:id]
      redirect_to managers_root_path
    end
  end
end
