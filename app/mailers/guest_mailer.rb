class GuestMailer < ApplicationMailer
  def invitation_guest
    # TO DO
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def cancel_invitation user, event
    @event = event
    @user = user
    mail(
      to: user.email,
      subject: I18n.t("user_mailer.cancel_title")
    )
  end
end
