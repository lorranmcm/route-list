import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['taskdescription'];

  opendescription(event) {
    fetch(`/projects/${this.element.dataset.project}/tasks/${event.currentTarget.dataset.taskId}`, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.taskdescriptionTarget.innerHTML = data;
      })

  }
}



// export default class extends Controller {
//   static targets = ['taskdesc'];

// savedescription(event) {
//   console.log(event.currentTarget.dataset.taskId)
//   patch(`/projects/${this.element.dataset.project}/tasks/${event.currentTarget.dataset.taskId}`, { headers: { 'Accept': 'text/plain' } })
//     .then(response => response.text())
//     .then((data) => {
//       this.taskdescriptionTarget.innerHTML = data;
//     })

// }
// }
