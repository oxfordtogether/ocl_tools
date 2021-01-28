// import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    console.log('hi?')
    setTimeout(() => {

      this.element.classList.add("hidden")
    }, 5000);
  }

  close() {
    this.element.classList.add("hidden");
  }
}
