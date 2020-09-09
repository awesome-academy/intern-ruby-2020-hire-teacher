class BusinessController < ActionController::Base
  layout "business"

  protect_from_forgery with: :exception
  before_action :authenticate_user!

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
    redirect_to new_user_session_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to business_home_url unless current_user? @user
  end

  def load_room_pagination
    @rooms = Room.page(params[:page]).per Settings.pagination
  end
end
