class Business::StaticPagesController < BusinessController
  before_action :logged_in_user

  def home; end

  def about; end
end
