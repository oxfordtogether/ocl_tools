"use strict";

require("core-js/modules/es.string.split.js");

require("core-js/modules/web.dom-collections.iterator.js");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  select(event) {
    event.preventDefault();
    this.inputTargetValue = event.currentTarget.getAttribute('data-value');
    this.iconTargets.forEach(el => {
      this.selectedClasses = el.getAttribute("data-selected-classes-value") != "" ? el.getAttribute("data-selected-classes-value").split(' ') : [];
      this.unselectedClasses = el.getAttribute("data-unselected-classes-value") != "" ? el.getAttribute("data-unselected-classes-value").split(' ') : [];

      if (el.getAttribute("data-value") == this.inputTargetValue) {
        if (this.selectedClasses.length > 0) el.classList.add(...this.selectedClasses);
        if (this.unselectedClasses.length > 0) el.classList.remove(...this.unselectedClasses);
      } else {
        if (this.selectedClasses.length > 0) el.classList.remove(...this.selectedClasses);
        if (this.unselectedClasses.length > 0) el.classList.add(...this.unselectedClasses);
      }
    });
    this.inputTarget.value = this.inputTargetValue;
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["input", "icon"]);

_defineProperty(_class, "values", {
  selectedClasses: String,
  unselectedClasses: String
});