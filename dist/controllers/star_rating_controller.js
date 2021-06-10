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
  constructor() {
    super(...arguments);

    _defineProperty(this, "listeners", []);
  }

  connect() {
    const initialRating = Number(this.ratingTarget.getAttribute("value") || 0);
    this.setRating(initialRating);
    this.starTargets.forEach(target => {
      this.addListener(target, () => this.setRating(target.getAttribute("data-value")));
    });
  }

  setRating(n) {
    this.ratingValue = n;
    this.colorStars(n);
    if (n > 0) this.ratingTarget.setAttribute("value", n);
  }

  colorStars(n) {
    this.starTargets.forEach(target => {
      if (target.getAttribute("data-value") <= n) {
        // should be on
        target.classList.remove(...(target.getAttribute("data-off") || "").split(" "));
        target.classList.add(...(target.getAttribute("data-on") || "").split(" "));
      } else {
        // should be off
        target.classList.remove(...(target.getAttribute("data-on") || "").split(" "));
        target.classList.add(...(target.getAttribute("data-off") || "").split(" "));
      }
    });
  }

  addListener(target, fcn) {
    target.addEventListener("click", fcn);
    this.listeners = [...this.listeners, [target, fcn]];
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["rating", "star"]);

_defineProperty(_class, "values", {
  rating: Number
});