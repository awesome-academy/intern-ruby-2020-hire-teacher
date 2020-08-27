class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    if user.activated?
      mail to: user.email, subject: t("managers.account_mailer.subject_activate")
    else
      mail to: user.email, subject: t("managers.account_mailer.subject_lock")
    end
  end
end
