class RoomLockingWorker
  include Sidekiq::Worker

  def perform room_id, room_name
    @users = User.includes(events: :room).get_user_now_booking(room_id).references :events
    @users.uniq.each do |user|
      RoomMailer.delay_for(Settings.worker.mail_room_delay.seconds).room_locking(user, room_name)
    end
  end
end
