"use strict";

require("core-js/modules/es.promise.js");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _core = require("@popperjs/core");

var _elTransition = require("el-transition");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Connects to data-controller="popper"
class _class extends _stimulus.Controller {
  connect() {
    // Create a new Popper instance
    this.popperInstance = (0, _core.createPopper)(this.elementTarget, this.popupTarget, {
      placement: this.placementValue,
      modifiers: [{
        name: "offset",
        options: {
          offset: this.offsetValue
        }
      }]
    });
  }

  toggle(e) {
    e.preventDefault();
    e.stopPropagation();
    this.popperInstance.update();
    (0, _elTransition.toggle)(this.contentTarget);
    (0, _elTransition.toggle)(this.overlayTarget);
  }

  close(e) {
    e.preventDefault();
    e.stopPropagation();
    (0, _elTransition.leave)(this.contentTarget);
    (0, _elTransition.leave)(this.overlayTarget);
  } // Destroy the Popper instance


  disconnect() {
    if (this.popperInstance) {
      this.popperInstance.destroy();
    }
  }

  nextFrame() {
    return new Promise(resolve => {
      requestAnimationFrame(() => {
        requestAnimationFrame(resolve);
      });
    });
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["element", "popup", "content", "overlay"]);

_defineProperty(_class, "values", {
  placement: {
    type: String,
    default: "bottom-end"
  },
  offset: {
    type: Array,
    default: [0, 8]
  }
});