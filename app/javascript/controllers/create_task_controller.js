import { Controller } from "stimulus";
import { buttonClickSelector, csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['taskdescription', 'form', 'display_description', 'buttoncreate', 'title', 'address', 'description'];


  newtask() {
    console.log(this.formTarget.task_title.value)
    // fetch(`/projects/${this.element.dataset.projectId}/tasks`, {
    //   method: 'POST',
    //   headers: { 'Accept': 'application/json', 'X-CSRF-Token': csrfToken(), 'Content-Type': 'application/json' },
    //   body: JSON.stringify({
    //     task: {
    //       title: this.formTarget.task_title.value,
    //       address: this.formTarget.task_address.value,
    //       description: this.formTarget.task_description.value
    //     }
    //   })
    // })
      .then(response => response.text())
      .then((data) => {
        this.buttoncreate.classList.replace("btn-warning", "btn-success");
        this.buttoncreate.value = "Saved!";
      })
  }
}
