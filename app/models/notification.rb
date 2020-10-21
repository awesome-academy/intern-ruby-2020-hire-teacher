class Notification < ApplicationRecord
  belongs_to :user

  enum active: {locked: false, opened: true}

  after_create_commit :push_notify

  scope :by_user, ->(user_id){where user_id: user_id if user_id.present?}

  private

  def push_notify
    ActionCable.server.broadcast "notification_#{user_id}",
                                 counter: render_counter(Notification.count),
                                 notification: render_notification(self)
  end

  def render_counter counter
    BusinessController.renderer
                      .render(partial: "business/notifications/counter",
                              locals: {counter: counter})
  end

  def render_notification notification
    BusinessController.renderer
                      .render(partial: "business/notifications/notification",
                              locals: {notification: notification})
  end

  def render_active_lock
    BusinessController.renderer.render(partial: "business/rooms/room_lock")
  end

  def render_active_unlock
    BusinessController.renderer.render(partial: "business/rooms/room_unlock")
  end
end
