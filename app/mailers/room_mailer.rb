class RoomMailer < ApplicationMailer
  def room_locking user, room_name
    @room_name = room_name
    @user = user
    mail to: @user.email, subject: t("user_mailer.room_locking", name: @room_name)
  end
end
