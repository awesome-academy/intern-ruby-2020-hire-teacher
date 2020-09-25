class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    if user.activated?
      mail to: user.email, subject: t("managers.account_mailer.subject_activate")
    else
      mail to: user.email, subject: t("managers.account_mailer.subject_lock")
    end
  end

  def invite_event guest
    @guest = guest
    mail to: guest.user.email, subject: ["Invite Event", guest.event.title].join(" ")
  end

  def active_event trainer
    @trainer = trainer
    mail to: trainer.email, subject: t(".active_event")
  end
end
