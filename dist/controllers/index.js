"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _stimulus = require("stimulus");

var _webpackHelpers = require("stimulus/webpack-helpers");

var _stimulus_reflex = _interopRequireDefault(require("stimulus_reflex"));

var _consumer = _interopRequireDefault(require("../channels/consumer"));

var _autocomplete_controller = _interopRequireDefault(require("./autocomplete_controller"));

var _conditional_fields_controller = _interopRequireDefault(require("./conditional_fields_controller"));

var _date_picker_controller = _interopRequireDefault(require("./date_picker_controller"));

var _file_upload_controller = _interopRequireDefault(require("./file_upload_controller"));

var _notice_controller = _interopRequireDefault(require("./notice_controller"));

var _search_controller = _interopRequireDefault(require("./search_controller"));

var _table_controller = _interopRequireDefault(require("./table_controller"));

var _visibility_toggle_controller = _interopRequireDefault(require("./visibility_toggle_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const application = _stimulus.Application.start();

const context = require.context("controllers", true, /_controller\.js$/);

application.load((0, _webpackHelpers.definitionsFromContext)(context));

_stimulus_reflex.default.initialize(application, {
  consumer: _consumer.default
});

const controllers = {
  autocomplete: _autocomplete_controller.default,
  "conditional-fields": _conditional_fields_controller.default,
  "date-picker": _date_picker_controller.default,
  notice: _notice_controller.default,
  "file-upload": _file_upload_controller.default,
  search: _search_controller.default,
  table: _table_controller.default,
  "visibility-toggle": _visibility_toggle_controller.default
};
var _default = controllers;
exports.default = _default;