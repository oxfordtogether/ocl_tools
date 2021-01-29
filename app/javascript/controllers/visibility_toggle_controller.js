// https://dev.to/mmccall10/tailwind-enter-leave-transition-effects-with-stimulus-js-5hl7
import { Controller } from "stimulus";
// import { toggle, leave, enter } from "el-transition";

export default class extends Controller {
  static targets = ["becomesVisible", "becomesInvisible"];

  toggle() {
    this.becomesVisibleTargets.forEach((target) => toggle(target));
    this.becomesInvisibleTargets.forEach((target) => toggle(target));
  }

  close() {
    this.becomesVisibleTargets.forEach((target) => leave(target));
    this.becomesInvisibleTargets.forEach((target) => enter(target));
  }
}
