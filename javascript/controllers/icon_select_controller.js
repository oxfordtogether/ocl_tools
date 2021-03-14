import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "icon"];
  static values = { selectedClasses: String, unselectedClasses: String}

  select(event) {
    event.preventDefault();
    this.inputTargetValue = event.currentTarget.getAttribute('data-value');

    this.iconTargets.forEach((el) => {
      this.selectedClasses = el.getAttribute("data-selected-classes-value") != "" ? el.getAttribute("data-selected-classes-value").split(' ') : []
      this.unselectedClasses = el.getAttribute("data-unselected-classes-value") != "" ? el.getAttribute("data-unselected-classes-value").split(' ') : []

      if (el.getAttribute("data-value") == this.inputTargetValue) {
        if (this.selectedClasses.length > 0) el.classList.add(...this.selectedClasses)
        if (this.unselectedClasses.length > 0) el.classList.remove(...this.unselectedClasses)
      } else {
        if (this.selectedClasses.length > 0) el.classList.remove(...this.selectedClasses)
        if (this.unselectedClasses.length > 0) el.classList.add(...this.unselectedClasses)
      }
    })

    this.inputTarget.value = this.inputTargetValue
  }
}
