class Managers::HomesController < ManagersController
  before_action :correct_manager, only: :index

  skip_authorization_check

  def index; end
end
