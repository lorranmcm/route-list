import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ["form", "title", "display_title"]

  refresh() {
    let id = event.target.form.dataset.id;
    fetchWithToken(`/projects/${id}`, {
      method: "PATCH",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        user: {
          title: this.title
        }
      })
    }).then(response => response.json())
      .then((data) => {
        console.log(data)
      });

    if (this.title != "") {
      this.display_titleTarget.innerText = `Mon adresse actuelle : ${this.title}`;
    }
  }

  get title() {
    return this.titleTarget.value
  }
}
