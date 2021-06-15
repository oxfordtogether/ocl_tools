import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["query", "activity", "count"];
  static values = {
    params: Object,
  };

  beforePerform() {
    this.activityTarget.hidden = false;
    this.countTarget.hidden = true;
  }

  perform(event) {
    event.preventDefault();

    if (isEmptyObject(this.paramsValue)) {
      this.stimulate("SearchReflex#perform", this.queryTarget.value);
    } else {
      this.stimulate(
        "SearchReflex#perform",
        this.queryTarget.value,
        this.paramsValue
      );
    }
  }
}

function isEmptyObject(obj) {
  for (const i in obj) return false;
  return true;
}
