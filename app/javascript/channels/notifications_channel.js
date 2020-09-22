import consumer from './consumer'

consumer.subscriptions.create('NotificationsChannel', {
  connected() {},

  disconnected() {},

  received(data) {
    $('.count-li').show();
    $('#notificationList').prepend(data.notification);
  }
});
