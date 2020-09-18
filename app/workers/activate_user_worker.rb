class ActivateUserWorker
  include Sidekiq::Worker

  def perform email
    @user = User.find_by email: email
    UserMailer.delay_for(Settings.worker.mail_delay.seconds).account_activation(@user)
  end
end
