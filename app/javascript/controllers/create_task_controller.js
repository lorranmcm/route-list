import { Controller } from "stimulus";
import { buttonClickSelector, csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['taskdescription', 'form', 'display_description', 'buttoncreate', 'title', 'address', 'description'];


  newtask() {
    console.log(this.element.dataset.projectId)
    console.log(this.element.dataset.taskId)
    console.log(this.element.dataset)
    fetch(`/projects/${this.element.dataset.projectId}/tasks`, {
      method: 'POST',
      headers: { 'Accept': 'application/json', 'X-CSRF-Token': csrfToken(), 'Content-Type': 'application/json' },
      body: JSON.stringify({
        task: {
          title: this.formTarget.task_title,
          address: this.formTarget.task_address.value,
          description: this.formTarget.task_description.value
        }
      })
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        
        this.buttoncreate.classList.replace("btn-warning", "btn-success");
        this.buttoncreate.value = "Saved!";
      })
  }
}
