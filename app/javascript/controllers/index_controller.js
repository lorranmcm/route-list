import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['taskdescription', 'userdescription'];

  opendescription(event) {
    fetch(`/projects/${this.element.dataset.projectId}/tasks/${event.currentTarget.dataset.taskId}`, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.taskdescriptionTarget.innerHTML = data;
      })
  }

  newtaskform(event) {
    event.preventDefault();
    fetch(`/projects/${this.element.dataset.projectId}/tasks/new`, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.taskdescriptionTarget.innerHTML = data;
      });
  }

  completetask() {
    
  }

  openUser(event){
    fetch(`/users/${event.currentTarget.dataset.userId}`, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.userdescriptionTarget.innerHTML = data;
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
