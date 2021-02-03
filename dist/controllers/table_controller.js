"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

class _default extends _stimulus.Controller {
  rowClick(e) {
    Turbolinks.visit(this.data.get("url"));
  }

}

exports.default = _default;