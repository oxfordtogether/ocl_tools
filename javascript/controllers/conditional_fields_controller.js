import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["optionA", "optionB"];

  connect() {
    if (this.data.get("option") == "OPTION_B") {
      this.optionATarget.classList.add("hidden");
      this.optionBTarget.classList.remove("hidden");
    } else {
      this.optionATarget.classList.remove("hidden");
      this.optionBTarget.classList.add("hidden");
    }
  }

  changed(evt) {
    switch (evt.currentTarget.getAttribute("data-value")) {
      case "OPTION_A":
        this.optionATarget.classList.remove("hidden");
        this.optionBTarget.classList.add("hidden");
        break;
      case "OPTION_B":
        this.optionATarget.classList.add("hidden");
        this.optionBTarget.classList.remove("hidden");
        break;
      default:
        this.optionATarget.classList.add("hidden");
        this.optionBTarget.classList.add("hidden");
    }
  }
}
