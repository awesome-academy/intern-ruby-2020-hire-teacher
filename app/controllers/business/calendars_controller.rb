class Business::CalendarsController < BusinessController
  def next
    @room_id = params[:id]
    @monday = if params[:day].nil?
                DateTime.now - DateTime.now.cwday + 1
              else
                Date.parse(params[:day]) + 7
              end
    @event_load = Event.where(room_id: @room_id)
    respond_to do |format|
      format.html{redirect_to business_room_path params[:id]}
      format.json{render json: {event_load: @event_load, monday: @monday, room_id: @room_id}}
      format.js
    end
  end

  def prev
    @room_id = params[:id]
    @monday = if params[:day].nil?
                DateTime.now - DateTime.now.cwday + 1
              else
                Date.parse(params[:day]) - 7
              end
    @event_load = Event.where(room_id: @room_id)
    respond_to do |format|
      format.html{redirect_to business_room_path params[:id]}
      format.json{render json: {event_load: @event_load, monday: @monday, room_id: @room_id}}
      format.js
    end
  end
end
