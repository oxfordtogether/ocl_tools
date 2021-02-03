"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  connect() {
    if (this.data.get('option') == 'OPTION_B') {
      this.optionATarget.classList.add("hidden");
      this.optionBTarget.classList.remove("hidden");
    } else {
      this.optionATarget.classList.remove("hidden");
      this.optionBTarget.classList.add("hidden");
    }
  }

  changed(evt) {
    switch (evt.currentTarget.getAttribute('data-value')) {
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

exports.default = _class;

_defineProperty(_class, "targets", ["optionA", "optionB"]);