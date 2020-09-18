# class SendMailInviteGuestWorker
#   include Sidekiq::Worker

#   def perform event_id
#     event = Event.find_by id: event_id
#     guests = event.guests
#     guests.each do |guest|
#       UserMailer.delay_for(Settings.worker.mail_delay.seconds).invite_event(guest)
#     end
#   end
# end
