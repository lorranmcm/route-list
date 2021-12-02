import { Controller } from "stimulus";
import { buttonClickSelector, csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['taskdescription', 'form', 'display_description', 'buttonnew'];

  opennewtaskform(event) {
    fetch(`create`, {
      method: 'GET',
      headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.taskdescriptionTarget.innerHTML = data;
      })

  newtask() {
    console.log(this.element.dataset.projectId)
    console.log(this.element.dataset.taskId)
    console.log(this.element.dataset)
    fetch(`/projects/${this.element.dataset.projectId}/tasks`, {
      method: 'POST',
      headers: { 'Accept': 'application/json"', 'X-CSRF-Token': csrfToken(), 'Content-Type': 'application/json' },
      body: JSON.stringify({
        task: {
          description: this.description
        }
      })
    })
      .then(response => response.text())
      .then((data) => {
        this.buttonTarget.classList.replace("btn-warning", "btn-success");
        this.buttonTarget.value = "Saved!";
      })
  }
}
