import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  editCard(e) {
    this.element.classList.add('hidden-icon');
    this.titleInputTarget.focus();
  }

  deleteCard(e) {
    console.log(this.titleInputTarget)
  }


  preventDefault(e) {
    e.preventDefault();
  }
}
