class InviteGuestWheneverWorker
  include Sidekiq::Worker

  def perform
    day = Time.zone.now
    events = Event.includes(:room).activate.in_room_active
    events.each_with_index do |event, index_event|
      next unless valid_day?(event.start_time, day) && valid_time?(event.start_time, day)

      GuestMailer.delay_for(time_delay(index_event))
                 .invitation_guest event.user, event
      users = User.includes(guests: :event)
                  .by_event_id event.id
      users.each_with_index do |user, index_user|
        sleep(Settings.worker.mail_delay)
        GuestMailer.delay_for(time_delay(index_user + index_event))
                   .invitation_guest user, event
      end
    end
  end

  private

  def valid_day? event, day
    day.to_date.eql? event.to_date
  end

  def valid_time? event, day
    time_event = event.hour * Settings.timezone._minute + event.min
    time_now = day.hour * Settings.timezone._minute + day.min
    time_diff = time_event - time_now
    time_diff >= 0 && time_diff <= Settings.timezone._minute.minutes
  end

  def time_delay index
    (Settings.worker.mail_delay + Settings.worker.mail_delay * index).seconds
  end
end
