"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _application_controller = _interopRequireDefault(require("./application_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class _default extends _application_controller.default {
  connect() {
    setTimeout(() => {
      this.element.classList.add("hidden");
    }, 5000);
  }

  close() {
    this.element.classList.add("hidden");
  }

}

exports.default = _default;