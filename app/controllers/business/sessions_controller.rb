class Business::SessionsController < Devise::SessionsController
  layout "business"

  protected

  def after_sign_in_path_for user
    managers_root_path if user.manager?

    business_home_path
  end

  def after_sign_out_path_for _user
    new_user_session_path
  end
end
