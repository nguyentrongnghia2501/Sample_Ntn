import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {


  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // console.log(data)
    const notificationZone = document.querySelector('.notification-list')
    const notificationConten = `
    <h5>${data.message} </h5>
    `



    notificationZone.innerHTML = notificationZone.innerHTML + notificationConten

  }
});
