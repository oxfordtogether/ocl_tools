"use strict";

require("core-js/modules/es.string.includes.js");

require("core-js/modules/web.dom-collections.iterator.js");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  connect() {
    this.selectedOptionsValues = this.data.get('initial-selected-options');
    this.inputTargets.forEach((el, i) => {
      if (this.selectedOptionsValues.includes(el.getAttribute("value"))) {
        el.setAttribute("disabled", "false");
      } else {
        el.setAttribute("disabled", "true");
      }
    });
    this.tagTargets.forEach((el, i) => {
      if (this.selectedOptionsValues.includes(el.getAttribute("data-value"))) {
        el.classList.remove("hidden");
      } else {
        el.classList.add("hidden");
      }
    });
    this.openTarget.classList.remove("hidden");
    this.closeTarget.classList.add("hidden");
  }

  open(event) {
    event.preventDefault();
    this.dropdownTarget.classList.remove("hidden");
    this.openTarget.classList.add("hidden");
    this.closeTarget.classList.remove("hidden");
  }

  close(event) {
    event.preventDefault();
    this.dropdownTarget.classList.add("hidden");
    this.openTarget.classList.remove("hidden");
    this.closeTarget.classList.add("hidden");
  }

  remove(event) {
    event.preventDefault();
    event.stopPropagation();
    const option = event.currentTarget.getAttribute("data-value");
    this.selectedOptionsValues = this.selectedOptionsValues.filter(v => v !== option);
    this.tagTargets.forEach((el, i) => {
      if (el.getAttribute("data-value") == option) {
        el.classList.add("hidden");
      }
    });
    this.inputTargets.forEach((el, i) => {
      if (this.selectedOptionsValues.includes(el.getAttribute("value"))) {
        el.setAttribute("disabled", "false");
      } else {
        el.setAttribute("disabled", "true");
      }
    });
  }

  select(event) {
    event.preventDefault();
    const option = event.currentTarget.value;

    if (!this.selectedOptionsValues.includes(option)) {
      this.selectedOptionsValues = [...this.selectedOptionsValues, option];
    }

    this.tagTargets.forEach((el, i) => {
      if (el.getAttribute("data-value") == option) {
        el.classList.remove("hidden");
      }
    });
    this.inputTargets.forEach((el, i) => {
      if (this.selectedOptionsValues.includes(el.getAttribute("value"))) {
        el.setAttribute("disabled", "false");
      } else {
        el.setAttribute("disabled", "true");
      }
    });
    this.dropdownTarget.classList.add("hidden");
    this.openTarget.classList.remove("hidden");
    this.closeTarget.classList.add("hidden");
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["tag", "input", "dropdown", "open", "close"]);

_defineProperty(_class, "values", {
  selectedOptions: Array
});