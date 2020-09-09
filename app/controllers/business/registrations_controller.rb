class Business::RegistrationsController < Devise::RegistrationsController
  before_action :get_group, only: %i(new create)
  before_action :configure_sign_up_params, only: :create
  layout "business"

  def new
    super
  end

  def create
    super
  end

  protected

  def after_sign_up_path_for _user
    business_home_path
  end

  private

  def get_group
    @group = Group.pluck :name, :id
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User::USER_PARAMS)
  end
end
