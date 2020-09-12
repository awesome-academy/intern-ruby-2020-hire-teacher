class ActivateUserWorker
  include Sidekiq::Worker

  def perform email
    @user = User.find_by email: email
    UserMailer.delay_for(30.seconds).account_activation(@user)
  end
end
