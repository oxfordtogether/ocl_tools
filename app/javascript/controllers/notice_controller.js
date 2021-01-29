import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {

      this.element.classList.add("hidden")
    }, 5000);
  }

  close() {
    this.element.classList.add("hidden");
  }
}
