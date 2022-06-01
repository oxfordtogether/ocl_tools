import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["query", "activity"];
  static values = {
    params: Object,
  };

  beforePerform() {
    this.activityTarget.hidden = false;
  }

  perform(event) {
    event.preventDefault();

    this.stimulate("SearchReflex#perform", this.queryTarget.value);
  }
}
