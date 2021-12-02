import { Controller } from "stimulus";
import { buttonClickSelector, csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['description', 'form', 'display_description', 'button'];

  connect(){
    this.projectValue = this.element.dataset.project
    this.taskValue = this.element.dataset.taskId
}

  edit(){
    console.log(this.element.dataset.projectId)
    console.log(this.element.dataset.taskId)
    console.log(this.element.dataset)
    fetch(`/projects/${this.element.dataset.projectId}/tasks/${this.element.dataset.taskId}`, {
      method: 'PATCH',
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
    })
  }

  editmode(){
    this.buttonTarget.classList.replace("btn-success", "btn-warning");
  }
}

// let button = document.querySelector("#editbutton");

// button.addEventListener('click', (event) => {

// // detail.js
// let description = document.getElementById("taskdesc")
// let csrftoken = getCookie('csrftoken');

// description.addEventListener("input", function () {
//   let newdescription = description.textContent
//   let data = { description: newdescription }

//   fetch('change_description/', {
//     method: 'PATCH',
//     headers: {
//       'Content-Type': 'application/json',
//       "X-CSRFToken": csrftoken,
//     },
//     body: JSON.stringify(data),
//     credentials: 'same-origin',
//   })
//     .then(response => response.json())
//     .then(data => {
//       console.log('Success: ', data)
//     })
//     .catch((error) => {
//       console.error('My Error: ', error)
//     })
// }, false);

// // The following function are copying from
// // https://docs.djangoproject.com/en/dev/ref/csrf/#ajax
// function getCookie(description) {
//   var cookieValue = null;
//   if (document.cookie && document.cookie !== '') {
//     var cookies = document.cookie.split(';');
//     for (var i = 0; i < cookies.length; i++) {
//       var cookie = cookies[i].trim();
//       // Does this cookie string begin with the description we want?
//       if (cookie.substring(0, description.length + 1) === (description + '=')) {
//         cookieValue = decodeURIComponent(cookie.substring(description.length + 1));
//         break;
//       }
//     }
//   }
//   return cookieValue;
// }
