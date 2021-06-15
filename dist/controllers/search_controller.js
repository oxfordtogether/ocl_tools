"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _application_controller = _interopRequireDefault(require("./application_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _application_controller.default {
  beforePerform() {
    this.activityTarget.hidden = false;
    this.countTarget.hidden = true;
  }

  perform(event) {
    event.preventDefault();

    if (isEmptyObject(this.paramsValue)) {
      this.stimulate("SearchReflex#perform", this.queryTarget.value);
    } else {
      this.stimulate("SearchReflex#perform", this.queryTarget.value, this.paramsValue);
    }
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["query", "activity", "count"]);

_defineProperty(_class, "values", {
  params: Object
});

function isEmptyObject(obj) {
  for (const i in obj) return false;

  return true;
}