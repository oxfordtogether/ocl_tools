"use strict";

require("core-js/modules/es.regexp.constructor.js");

require("core-js/modules/es.regexp.to-string.js");

require("core-js/modules/es.string.match.js");

require("core-js/modules/es.string.split.js");

require("core-js/modules/web.dom-collections.iterator.js");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _debug = _interopRequireDefault(require("debug"));

require("core-js/stable");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _templateObject2() {
  const data = _taggedTemplateLiteral(["\n            Unsupported input type: ", " ", "\n\n            Conditional fields sources must be one of:\n              * select box\n              * radio button\n              * checkbox\n              * hidden\n            "]);

  _templateObject2 = function _templateObject2() {
    return data;
  };

  return data;
}

function _templateObject() {
  const data = _taggedTemplateLiteral([""]);

  _templateObject = function _templateObject() {
    return data;
  };

  return data;
}

function _taggedTemplateLiteral(strings, raw) { if (!raw) { raw = strings.slice(0); } return Object.freeze(Object.defineProperties(strings, { raw: { value: Object.freeze(raw) } })); }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// to turn on debugging run the following in the js console in the browser:
// localStorage.debug = 'ocl-tools:*'
const debug = (0, _debug.default)("ocl-tools:better-conditional-fields");

class _class extends _stimulus.Controller {
  constructor() {
    super(...arguments);

    _defineProperty(this, "listeners", []);
  }

  connect() {
    debug("connecting: ".concat(this.sourceTargets.length, " source targets found"));
    this.sourceTargets.forEach(target => {
      const targetType = target.getAttribute("type");

      if (target.tagName === "SELECT") {
        this.connectSelectSource(target);
      } else if (target.tagName === "INPUT" && targetType === "radio") {
        this.connectRadioSource(target);
      } else if (target.tagName === "INPUT" && targetType === "checkbox") {
        this.connectCheckBoxSource(target);
      } else if (target.tagName === "INPUT" && targetType === "hidden") {
        this.connectHiddenSource(target);
      } else {
        throw new Error(""(_templateObject2(), target.tagName, targetType || "")(_templateObject()));
      }
    });
    this.updateTargets();
  }

  connectSelectSource(target) {
    const name = target.getAttribute("data-name");
    const value = target.value;
    this.addListener(target, e => this.setToken(name, e.target.value));
    this.setToken(name, value); // initial value

    debug("added listener to select: setToken(".concat(name, ", *)"));
  }

  connectRadioSource(target) {
    const {
      name,
      value
    } = getNameAndValue(target);
    this.addListener(target, e => this.setToken(name, value));
    if (target.checked) this.setToken(name, value); // initial value

    debug("added listener to radio input: setToken(".concat(name, ", ").concat(value, ")"));
  }

  connectCheckBoxSource(target) {
    const {
      name,
      value
    } = getNameAndValue(target);
    this.addListener(target, e => {
      e.target.checked ? this.addToken(name, value) : this.removeToken(name, value);
    });
    if (target.checked) this.addToken(name, value); // initial value

    debug("added listener to checkbox: addRemove(".concat(name, ", ").concat(value, ")"));
  }

  connectHiddenSource(target) {
    const {
      name,
      value
    } = getNameAndValue(target);
    this.addListener(target, e => this.setToken(name, e.target.value));
    this.setToken(name, value); // initial value

    debug("added listener to hidden input: setToken(".concat(name, ", *)"));
  }

  addListener(target, fcn) {
    target.addEventListener("change", fcn);
    this.listeners = [...this.listeners, [target, fcn]];
  }

  disconnect() {
    this.listeners.forEach((_ref) => {
      let [target, fcn] = _ref;
      return target.removeEventListener("change", fcn);
    });
  }
  /**
   * To be used as a data-action to manually set the value of a hidden field. Useful
   * for creating buttons/images/icons that control form elements
   *
   * Example:
   *
   *  <div data-action='click->better-conditional-fields#setField' data-token='rating:4'>
   */


  setField(event) {
    const token = event.currentTarget.getAttribute("data-token");
    debug("setField(token: '".concat(token, "')"));
    const {
      name,
      value
    } = splitToken(token);
    const source = this.sourceTargets.find(target => {
      const {
        name: targetName
      } = getNameAndValue(target);
      return name === targetName;
    });
    if (!source) throw Error("Couldn't find field with name ".concat(name));
    if (source.getAttribute("type") !== "hidden") throw Error("setField only supported for hidden fields");
    source.value = value;
    this.setToken(name, value);
  }
  /**
   * Sets a unique token for the given name, removing any existing tokens
   */


  setToken(name, value) {
    this._setToken(name, value);

    debug("setting tokens: %o", this.tokensValue);
    this.updateTargets();
  }

  _setToken(name, value) {
    this.tokensValue = [...this.tokensValue.filter(x => splitToken(x).name !== name), makeToken(name, value)];
  }
  /**
   * Adds a token to the list of tokens. Allows multiple tokens for a given name
   */


  addToken(name, value) {
    this._addToken(name, value);

    debug("addToken: %o", this.tokensValue);
    this.updateTargets();
  }

  _addToken(name, value) {
    this.tokensValue = [...this.tokensValue, makeToken(name, value)];
  }
  /**
   * Removes a token to the list of tokens.
   */


  removeToken(name, value) {
    const token = makeToken(name, value);
    debug("removing token: ".concat(token));
    this.tokensValue = [...this.tokensValue.filter(x => x !== token)];
    debug("setting tokens: %o", this.tokensValue);
    this.updateTargets();
  }

  updateTargets() {
    debug("updating ".concat(this.targetTargets.length, " targets"));
    this.targetTargets.forEach(target => {
      if (target.getAttribute("data-display-unless")) {
        const token = target.getAttribute("data-display-unless");
        const token_regex = new RegExp(token);

        if (this.tokensValue.map(t => !!t.match(token_regex)).some(v => !!v)) {
          target.classList.add("hidden");
          target.setAttribute("disabled", true);
        } else {
          target.classList.remove("hidden");
          target.removeAttribute("disabled");
        }
      } else if (target.getAttribute("data-display-if")) {
        const token = target.getAttribute("data-display-if");
        const token_regex = new RegExp(token);

        if (this.tokensValue.map(t => !!t.match(token_regex)).some(v => !!v)) {
          target.classList.remove("hidden");
          target.removeAttribute("disabled");
        } else {
          target.classList.add("hidden");
          target.setAttribute("disabled", true);
        }
      }
    });
  }

}

exports.default = _class;

_defineProperty(_class, "targets", ["source", "target"]);

_defineProperty(_class, "values", {
  tokens: Array
});

function getNameAndValue(target) {
  const name = target.getAttribute("data-name") || target.getAttribute("name");
  const value = target.getAttribute("data-value") || target.getAttribute("value");
  return {
    name,
    value
  };
}

function makeToken(name, value) {
  return "".concat(name, ".").concat(value);
}

function splitToken(token) {
  const [name, value] = token.split(".");
  return {
    name,
    value
  };
}