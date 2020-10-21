class BusinessController < ActionController::Base
  layout "business"

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to business_rooms_url
    flash[:error] = exception.message
  end

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

  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end

  def load_notification
    @notifications = Notification.by_user(current_user.id).reverse
  end
end
