namespace :batch do
  desc "Send mail to invite guest"

  task invite_messages: :environment do
    puts "RUNNING job send mail schedule"
    InviteGuestWheneverWorker.perform_async
  end
end
