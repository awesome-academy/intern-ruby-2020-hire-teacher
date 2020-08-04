class MailToGuestWorker
  include Sidekiq::Worker

  def perform event_id
    event = Event.find_by id: event_id
    users = User.includes(guests: :event).where("events.id = ?", event_id).references(:guests)

    if event.activate? && event.room_active == "opened"
      GuestMailer.delay_for(Settings.woker.mail_delay.seconds).invitation_guest(event.user, event)
      users.each do |user|
        GuestMailer.delay_for(Settings.woker.mail_delay.seconds).invitation_guest(user, event)
      end
    elsif event.inactivate? && event.room_active == "locked"
      users.each do |user|
        GuestMailer.delay_for(Settings.woker.mail_delay.seconds).cancel_invitation(user, event)
      end
    end
  end
end
