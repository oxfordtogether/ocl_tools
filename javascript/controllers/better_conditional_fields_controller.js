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
      } else if (target.tagName === "INPUT" && targetType === "hidden") {
        this.connectHiddenSource(target);
      } else {
        throw new Error(
          ```
            Unsupported input type: ${target.tagName} ${targetType || ""}

            Conditional fields sources must be one of:
              * select box
              * radio button
              * checkbox
              * hidden
            ```
        );
      }
    });
    this.updateTargets();
  }

  connectSelectSource(target) {
    const name = target.getAttribute("data-name");
    const value = target.value;

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

  connectHiddenSource(target) {
    const { name, value } = getNameAndValue(target);
    this.addListener(target, (e) => this.setToken(name, e.target.value));
    this.setToken(name, value); // initial value
    debug(`added listener to hidden input: setToken(${name}, *)`);
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
   * To be used as a data-action to manually set the value of a hidden field. Useful
   * for creating buttons/images/icons that control form elements
   *
   * Example:
   *
   *  <div data-action='click->better-conditional-fields#setField' data-token='rating:4'>
   */
  setField(event) {
    const token = event.currentTarget.getAttribute("data-token");
    debug(`setField(token: '${token}')`);
    const { name, value } = splitToken(token);
    const source = this.sourceTargets.find((target) => {
      const { name: targetName } = getNameAndValue(target);
      return name === targetName;
    });
    if (!source) throw Error(`Couldn't find field with name ${name}`);
    if (source.getAttribute("type") !== "hidden")
      throw Error(`setField only supported for hidden fields`);

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
          target.setAttribute("disabled", true)
        } else {
          target.classList.remove("hidden");
          target.removeAttribute("disabled")
        }
      } else if (target.getAttribute("data-display-if")) {
        const token = target.getAttribute("data-display-if");
        const token_regex = new RegExp(token);

        if (
          this.tokensValue.map((t) => !!t.match(token_regex)).some((v) => !!v)
        ) {
          target.classList.remove("hidden");
          target.removeAttribute("disabled")
        } else {
          target.classList.add("hidden");
          target.setAttribute("disabled", true)
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
