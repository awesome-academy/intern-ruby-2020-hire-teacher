import consumer from "./consumer"

consumer.subscriptions.create("StatusRoomChannel", {
  connected() {},

  disconnected() {},

  received(data) {
    $('.room-1').html(data.active);
  }
});
