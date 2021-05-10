"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

class _class extends _stimulus.Controller {
  addTagNode(value, label) {
    const wrapperDiv = document.createElement("DIV");
    wrapperDiv.setAttribute("data-multiple-select-target", "tag");
    wrapperDiv.setAttribute("data-value", value);
    wrapperDiv.setAttribute("data-label", label);
    wrapperDiv.setAttribute("class", "inline-block flex items-center border border-gray-300 rounded-md py-0.5 px-1.5 mr-2 my-0.5");
    const labelDiv = document.createElement("DIV");
    labelDiv.setAttribute("class", "text-sm text-gray-600 pr-1.5");
    labelDiv.innerHTML = label;
    const removeDiv = document.createElement("DIV");
    removeDiv.setAttribute("data-value", value);
    removeDiv.setAttribute("data-action", "click->multiple-select#remove");
    removeDiv.setAttribute("class", "p-0.5 rounded-full hover:bg-gray-200 font-bold text-gray-700");
    removeDiv.innerHTML = "\n      <svg xmlns=\"http://www.w3.org/2000/svg\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" class=\"h-4 w-4\">\n        <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M6 18L18 6M6 6l12 12\" />\n      </svg>\n    ";
    const input = document.createElement("INPUT");
    input.setAttribute("name", "".concat(this.data.get("name"), "[]"));
    input.setAttribute("id", this.data.get("id"));
    input.setAttribute("type", "text");
    input.setAttribute("value", value);
    input.setAttribute("hidden", true);
    wrapperDiv.appendChild(labelDiv);
    wrapperDiv.appendChild(removeDiv);
    wrapperDiv.appendChild(input);
    this.selectedTarget.prepend(wrapperDiv);
    this.selectedOptionsNodes[value] = wrapperDiv;
  }

  removeTagNode(value) {
    const toRemove = this.selectedOptionsNodes[value];
    toRemove.parentNode.removeChild(toRemove);
    delete this.selectedOptionsNodes[value];
  }

  connect() {
    this.selectedOptionsNodes = {};
    const initialValues = JSON.parse(this.data.get('initial-selected-options'));
    initialValues.forEach(value => {
      this.addTagNode(value[1], value[0]);
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
    this.removeTagNode(option);
  }

  select(event) {
    event.preventDefault();
    const value = event.currentTarget.value;
    const label = event.currentTarget.getAttribute("data-label");

    if (!(value in this.selectedOptionsNodes)) {
      this.addTagNode(value, label);
    }

    this.dropdownTarget.classList.add("hidden");
    this.openTarget.classList.remove("hidden");
    this.closeTarget.classList.add("hidden");
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["tag", "input", "selected", "dropdown", "open", "close", "inputWrapper"]);

_defineProperty(_class, "values", {
  selectedOptions: Array,
  id: String,
  name: String
});