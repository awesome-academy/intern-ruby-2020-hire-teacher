class Business::ReportsController < BusinessController
  before_action :set_report, only: :destroy
  before_action :load_room, only: :create
  before_action :logged_in_user

  def create
    if params[:report][:parent_id].to_i.positive?
      parent = Report.find_by id: params[:report].delete(:parent_id)
      @report = parent.children.build report_params
    else
      @report = Report.new report_params
    end
    if @report.save
      respond_to do |format|
        format.html{redirect_to business_room_path params[:report][:room_id]}
        format.json{render room: @room}
        format.js
      end
    else
      respond_to do |format|
        format.html{redirect_to business_room_path params[:report][:room_id]}
        format.json{render error: @report.errors.messages}
        format.js
      end
    end
  end

  def destroy
    @report.descendants.each(&:destroy)
    @report.destroy
    respond_to do |format|
      format.html{redirect_to business_room_path @report.room_id}
      format.js
    end
  end

  private
  def load_room
    @room = Room.find_by id: params[:report][:room_id]
    return if @room

    flash[:danger] = t "business.room.error_load_room"
  end

  def report_params
    params.require(:report).permit :room_id, :user_id, :comment
  end

  def set_report
    @report = Report.find_by id: params[:id]
  end
end
