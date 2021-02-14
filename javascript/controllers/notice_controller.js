import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {
    setTimeout(() => {

      this.element.classList.add("hidden")
    }, 5000);
  }

  close() {
    this.element.classList.add("hidden");
  }
}
