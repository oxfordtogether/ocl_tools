import { Controller } from "stimulus";
import { createPopper } from "@popperjs/core";
import { toggle, leave, enter } from "el-transition";

// Connects to data-controller="popper"
export default class extends Controller {
  static targets = ["element", "popup", "content", "overlay"];
  static values = {
    placement: { type: String, default: "bottom-end" },
    offset: { type: Array, default: [0, 8] },
  };

  connect() {
    // Create a new Popper instance
    this.popperInstance = createPopper(this.elementTarget, this.popupTarget, {
      placement: this.placementValue,
      modifiers: [
        {
          name: "offset",
          options: {
            offset: this.offsetValue,
          },
        },
      ],
    });
  }

  toggle(e) {
    e.preventDefault();
    e.stopPropagation();
    this.popperInstance.update();
    toggle(this.contentTarget);
    toggle(this.overlayTarget);
  }

  close(e) {
    e.preventDefault();
    e.stopPropagation();
    leave(this.contentTarget);
    leave(this.overlayTarget);
  }

  // Destroy the Popper instance
  disconnect() {
    if (this.popperInstance) {
      this.popperInstance.destroy();
    }
  }

  nextFrame() {
    return new Promise((resolve) => {
      requestAnimationFrame(() => {
        requestAnimationFrame(resolve);
      });
    });
  }
}
