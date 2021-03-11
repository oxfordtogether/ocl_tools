"use strict";

require("core-js/modules/es.string.includes.js");

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
  const data = _taggedTemplateLiteral(["\n            Unsupported input type: ", " ", "\n\n            Conditional fields sources must be one of:\n              * select box\n              * radio button\n              * checkbox\n            "]);

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
      } else {
        throw new Error(""(_templateObject2(), target.tagName, targetType || "")(_templateObject()));
      }
    });
  }

  connectSelectSource(target) {
    const {
      name
    } = getNameAndValue(target);
    this.addListener(target, e => this.setToken(name, e.target.value));
    debug("added listener to select: setToken(".concat(name, ", *)"));
  }

  connectRadioSource(target) {
    const {
      name,
      value
    } = getNameAndValue(target);
    this.addListener(target, e => this.setToken(name, value));
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
    debug("added listener to checkbox: addRemove(".concat(name, ", ").concat(value, ")"));
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
   * Sets a unique token for the given name, removing any existing tokens
   */


  setToken(name, value) {
    this.tokensValue = [...this.tokensValue.filter(x => splitToken(x).name !== name), makeToken(name, value)];
    debug("setting tokens: %o", this.tokensValue);
    this.updateTargets();
  }
  /**
   * Adds a token to the list of tokens. Allows multiple tokens for a given name
   */


  addToken(name, value) {
    this.tokensValue = [...this.tokensValue, makeToken(name, value)];
    debug("setting tokens: %o", this.tokensValue);
    this.updateTargets();
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

        if (this.tokensValue.includes(token)) {
          target.classList.add("hidden");
        } else {
          target.classList.remove("hidden");
        }
      } else if (target.getAttribute("data-display-if")) {
        const token = target.getAttribute("data-display-if");

        if (this.tokensValue.includes(token)) {
          target.classList.remove("hidden");
        } else {
          target.classList.add("hidden");
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