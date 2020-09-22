class StatusRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "status_room_channel"
  end
end
