"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _debug = _interopRequireDefault(require("debug"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// to turn on debugging run the following in the js console in the browser:
// localStorage.debug = 'ocl-tools:*'
const debug = (0, _debug.default)("ocl-tools:controlled_field");

class _class extends _stimulus.Controller {
  // "data-name": "who-to-contact"
  connect() {
    debug("Connecting controlled field");
  }

  set(event) {
    console.log("blah");
    event.preventDefault();
    const value = event.currentTarget.getAttribute("data-value");
    this.targetTarget.value = value;
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["target"]);