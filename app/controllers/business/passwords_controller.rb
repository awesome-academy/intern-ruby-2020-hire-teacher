class Business::PasswordsController < Devise::PasswordsController
  layout "business"

  protected

  def after_resetting_password_path_for _user
    business_home_path
  end
end
