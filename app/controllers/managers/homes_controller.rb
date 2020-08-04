class Managers::HomesController < ManagersController
  before_action :correct_manager, only: :index

  def index; end
end
