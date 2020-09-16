class Business::RegistrationsController < Devise::RegistrationsController
  before_action :get_group, only: %i(new create)
  before_action :configure_sign_up_params, :check_captcha, only: :create
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

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate
    set_minimum_password_length
    respond_with_navigational(resource){render :new}
  end
end
