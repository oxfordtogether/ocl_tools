import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["query", "activity"];
  static values = {
    reflex: String,
  };

  beforePerform() {
    this.activityTarget.hidden = false;
  }

  perform(event) {
    event.preventDefault();

    this.stimulate(this.reflexValue, this.queryTarget.value);
  }
}
