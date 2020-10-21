class Business::ReportsController < BusinessController
  before_action :load_notification
  before_action :set_report, only: :destroy
  before_action :load_room, only: :create

  def create
    if params[:report][:parent_id].to_i.positive?
      parent = Report.find_by id: params[:report].delete(:parent_id)
      @report = parent.children.build report_params
    else
      @report = Report.new report_params
    end
    respond_to do |format|
      format.html{redirect_to business_room_path params[:report][:room_id]}
      format.js
      if @report.save
        format.json{render room: @room}
      else
        format.json{render error: @report.errors.messages}
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

    flash[:error] = t "business.room.error_load_room"
    redirect_to business_home_path
  end

  def report_params
    params.require(:report).permit Report::REPORT_PARAMS
  end

  def set_report
    @report = Report.find_by id: params[:id]
    return if @report

    flash[:error] = t "business.room.error_load_room"
    redirect_to business_home_path
  end
end
