import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["query", "activity", "count"];

  beforePerform() {
    this.activityTarget.hidden = false;
    this.countTarget.hidden = true;
  }

  perform(event) {
    event.preventDefault();

    this.classname = this.data.get("classname")

    if (this.classname) {
      this.stimulate("SearchReflex#perform", this.queryTarget.value, this.classname);
    } else {
      this.stimulate("SearchReflex#perform", this.queryTarget.value);
    }
  }
}
