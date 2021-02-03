import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "fileName"];

  select(e) {
    this.fileNameTarget.textContent = this.inputTarget.value
  }
}
