class SendMailActiveEventWorker
  include Sidekiq::Worker

  def perform group_id
    trainers = User.get_trainer group_id
    trainers.each do |trainer|
      UserMailer.delay_for(Settings.worker.mail_delay.seconds).active_event(trainer)
    end
  end
end
