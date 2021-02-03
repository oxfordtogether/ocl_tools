"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  select(e) {
    this.fileNameTarget.textContent = this.inputTarget.value;
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["input", "fileName"]);