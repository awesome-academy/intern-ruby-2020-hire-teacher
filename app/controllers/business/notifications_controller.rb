class Business::NotificationsController < BusinessController
  def index
    @notifications = Notification.page(params[:page]).per Settings.pagination
  end
end
