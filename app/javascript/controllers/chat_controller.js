import { Controller } from "stimulus"
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["chatbox"]
  openchat(event) {
    const chatId = event.currentTarget.dataset.chatId
    fetch(`/chatrooms/${chatId}`, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        console.log(data);
        this.chatboxTarget.innerHTML = data;
        const messagesContainer = document.getElementById('messages');
        consumer.subscriptions.create({ channel: "ChatroomChannel", id: chatId }, {
          received(data) {
            messagesContainer.insertAdjacentHTML('beforeend', data);
            const formContainer = document.getElementById('message_content');
            formContainer.value = '';
          }
        });
      })
  }
}
