"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _stimulus_reflex = _interopRequireDefault(require("stimulus_reflex"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* This is your ApplicationController.
 * All StimulusReflex controllers should inherit from this class.
 *
 * Example:
 *
 *   import ApplicationController from './application_controller'
 *
 *   export default class extends ApplicationController { ... }
 *
 * Learn more at: https://docs.stimulusreflex.com
 */
class _default extends _stimulus.Controller {
  connect() {
    _stimulus_reflex.default.register(this);
  }
  /* Application-wide lifecycle methods
   *
   * Use these methods to handle lifecycle concerns for the entire application.
   * Using the lifecycle is optional, so feel free to delete these stubs if you don't need them.
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Example#demo"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */


  beforeReflex(element, reflex, noop, reflexId) {// document.body.classList.add('wait')
  }

  reflexSuccess(element, reflex, noop, reflexId) {// show success message etc...
  }

  reflexError(element, reflex, error, reflexId) {// show error message etc...
  }

  afterReflex(element, reflex, noop, reflexId) {// document.body.classList.remove('wait')
  }

}

exports.default = _default;