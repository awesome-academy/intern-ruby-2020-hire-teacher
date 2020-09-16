class Sendmail
  def initialize; end

  def mail_to_booking_user room
    return if room.opened?

    RoomLockingWorker.perform_async room.id, room.name
  end
end
