"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _elTransition = require("el-transition");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  toggle() {
    this.becomesVisibleTargets.forEach(target => (0, _elTransition.toggle)(target));
    this.becomesInvisibleTargets.forEach(target => (0, _elTransition.toggle)(target));
  }

  close() {
    this.becomesVisibleTargets.forEach(target => (0, _elTransition.leave)(target));
    this.becomesInvisibleTargets.forEach(target => (0, _elTransition.enter)(target));
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["becomesVisible", "becomesInvisible"]);