import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["view", "edit", "titleInput", "projectTitle", "form"];

  editCard(e) {
    this.element.classList.add('is-editing');
    this.titleInputTarget.focus();
  }


  preventDefault(e) {
    e.preventDefault();
  }
}
