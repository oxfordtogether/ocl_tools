import { Controller } from "stimulus";
import Debug from "debug";
import "core-js/stable";

// to turn on debugging run the following in the js console in the browser:
// localStorage.debug = 'ocl-tools:*'
const debug = Debug("ocl-tools:better-conditional-fields");

export default class extends Controller {
  static targets = ["source", "target"];
  static values = {
    tokens: Array,
  };
  listeners = [];

  connect() {
    debug(`connecting: ${this.sourceTargets.length} source targets found`);
    this.sourceTargets.forEach((target) => {
      const targetType = target.getAttribute("type");
      if (target.tagName === "SELECT") {
        this.connectSelectSource(target);
      } else if (target.tagName === "INPUT" && targetType === "radio") {
        this.connectRadioSource(target);
      } else if (target.tagName === "INPUT" && targetType === "checkbox") {
        this.connectCheckBoxSource(target);
      } else {
        throw new Error(
          ```
            Unsupported input type: ${target.tagName} ${targetType || ""}

            Conditional fields sources must be one of:
              * select box
              * radio button
              * checkbox
            ```
        );
      }
    });
    this.updateTargets();
  }

  connectSelectSource(target) {
    const { name, value } = getNameAndValue(target);
    this.addListener(target, (e) => this.setToken(name, e.target.value));
    this.setToken(name, value); // initial value
    debug(`added listener to select: setToken(${name}, *)`);
  }

  connectRadioSource(target) {
    const { name, value } = getNameAndValue(target);
    this.addListener(target, (e) => this.setToken(name, value));
    if (target.checked) this.setToken(name, value); // initial value
    debug(`added listener to radio input: setToken(${name}, ${value})`);
  }

  connectCheckBoxSource(target) {
    const { name, value } = getNameAndValue(target);
    this.addListener(target, (e) => {
      e.target.checked
        ? this.addToken(name, value)
        : this.removeToken(name, value);
    });
    if (target.checked) this.addToken(name, value); // initial value
    debug(`added listener to checkbox: addRemove(${name}, ${value})`);
  }

  addListener(target, fcn) {
    target.addEventListener("change", fcn);
    this.listeners = [...this.listeners, [target, fcn]];
  }

  disconnect() {
    this.listeners.forEach(([target, fcn]) =>
      target.removeEventListener("change", fcn)
    );
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
    this.tokensValue = [
      ...this.tokensValue.filter((x) => splitToken(x).name !== name),
      makeToken(name, value),
    ];
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
    debug(`removing token: ${token}`);
    this.tokensValue = [...this.tokensValue.filter((x) => x !== token)];
    debug("setting tokens: %o", this.tokensValue);
    this.updateTargets();
  }

  updateTargets() {
    debug(`updating ${this.targetTargets.length} targets`);
    this.targetTargets.forEach((target) => {
      if (target.getAttribute("data-display-unless")) {
        const token = target.getAttribute("data-display-unless");
        const token_regex = new RegExp(token);

        if (
          this.tokensValue.map((t) => !!t.match(token_regex)).some((v) => !!v)
        ) {
          target.classList.add("hidden");
        } else {
          target.classList.remove("hidden");
        }
      } else if (target.getAttribute("data-display-if")) {
        const token = target.getAttribute("data-display-if");
        const token_regex = new RegExp(token);

        if (
          this.tokensValue.map((t) => !!t.match(token_regex)).some((v) => !!v)
        ) {
          target.classList.remove("hidden");
        } else {
          target.classList.add("hidden");
        }
      }
    });
  }
}

function getNameAndValue(target) {
  const name = target.getAttribute("data-name") || target.getAttribute("name");
  const value =
    target.getAttribute("data-value") || target.getAttribute("value");
  return { name, value };
}

function makeToken(name, value) {
  return `${name}.${value}`;
}

function splitToken(token) {
  const [name, value] = token.split(".");
  return { name, value };
}
