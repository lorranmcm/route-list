import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["view", "edit", "titleInput", "projectTitle", "form"];

  connect() {
    console.log(this.element)
    // document.addEventListener("turbolinks:before-visit", (e) => {
    //   this.saveCard();
    // }, { once: true });
  }

  editCard(e) {
    this.element.classList.add('is-editing');
    this.titleInputTarget.focus();
  }

  submitSaveForm(e) {
    // e.preventDefault();
  }

  onFormSubmit(e) {
    e.preventDefault();

    const formData = new FormData(this.formTarget);
    console.log(this.formTarget, formData.get('project'));
    console.log('wat');
  }

  saveCard(e) {
    e.preventDefault();
    // e.preventDefault();
    // console.log(e);
    fetch(`/projects/${this.titleInputTarget.dataset.projectId}`, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      });
    this.projectTitleTarget.innerText = this.titleInputTarget.value;
    this.element.classList.remove('is-editing');
   }

  preventDefault(e) {
    e.preventDefault();
  }
}
