"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _application_controller = _interopRequireDefault(require("./application_controller"));

var _stimulusUse = require("stimulus-use");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _application_controller.default {
  connect() {
    super.connect();
    (0, _stimulusUse.useClickOutside)(this);
  }

  search(event) {
    event.preventDefault();
    this.searchIconTarget.hidden = true;
    this.searchingIconTarget.hidden = false;
    this.stimulate(this.reflexValue, this.queryTarget.value);
  }

  select(event) {
    event.preventDefault();
    const id = event.currentTarget.getAttribute("data-value");
    this.valueTarget.value = id;
    this.dropdownTarget.hidden = true;
    this.queryTarget.value = event.currentTarget.getAttribute("data-display");
  }

  clickOutside() {
    // clears the value from the query box if the id isn't set
    // (assumes that if the id is set, then the corresponding name will be in the query box)
    if (!this.valueTarget.value) {
      this.queryTarget.value = "";

      if (this.hasDropdownTarget) {
        this.dropdownTarget.hidden = true;
      }
    }
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["query", "value", "dropdown", "searchIcon", "searchingIcon"]);

_defineProperty(_class, "values", {
  reflex: String
});