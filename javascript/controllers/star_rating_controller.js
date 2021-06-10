import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["rating", "star"];
  static values = { rating: Number };
  listeners = [];

  connect() {
    const initialRating = Number(this.ratingTarget.getAttribute("value") || 0);
    this.setRating(initialRating);

    this.starTargets.forEach((target) => {
      this.addListener(target, () =>
        this.setRating(target.getAttribute("data-value"))
      );
    });
  }

  setRating(n) {
    this.ratingValue = n;
    this.colorStars(n);
    if (n > 0) this.ratingTarget.setAttribute("value", n);
  }

  colorStars(n) {
    this.starTargets.forEach((target) => {
      if (target.getAttribute("data-value") <= n) {
        // should be on
        target.classList.remove(
          ...(target.getAttribute("data-off") || "").split(" ")
        );
        target.classList.add(
          ...(target.getAttribute("data-on") || "").split(" ")
        );
      } else {
        // should be off
        target.classList.remove(
          ...(target.getAttribute("data-on") || "").split(" ")
        );
        target.classList.add(
          ...(target.getAttribute("data-off") || "").split(" ")
        );
      }
    });
  }

  addListener(target, fcn) {
    target.addEventListener("click", fcn);
    this.listeners = [...this.listeners, [target, fcn]];
  }
}
