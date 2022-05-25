"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _autocomplete_controller = _interopRequireDefault(require("./autocomplete_controller"));

var _bar_chart_controller = _interopRequireDefault(require("./bar_chart_controller"));

var _better_autocomplete_controller = _interopRequireDefault(require("./better_autocomplete_controller"));

var _better_conditional_fields_controller = _interopRequireDefault(require("./better_conditional_fields_controller"));

var _conditional_fields_controller = _interopRequireDefault(require("./conditional_fields_controller"));

var _date_picker_controller = _interopRequireDefault(require("./date_picker_controller"));

var _file_upload_controller = _interopRequireDefault(require("./file_upload_controller"));

var _icon_select_controller = _interopRequireDefault(require("./icon_select_controller"));

var _notice_controller = _interopRequireDefault(require("./notice_controller"));

var _popper_controller = _interopRequireDefault(require("./popper_controller"));

var _search_controller = _interopRequireDefault(require("./search_controller"));

var _star_rating_controller = _interopRequireDefault(require("./star_rating_controller"));

var _table_controller = _interopRequireDefault(require("./table_controller"));

var _visibility_toggle_controller = _interopRequireDefault(require("./visibility_toggle_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const controllers = {
  autocomplete: _autocomplete_controller.default,
  "bar-chart": _bar_chart_controller.default,
  "better-autocomplete": _better_autocomplete_controller.default,
  "better-conditional-fields": _better_conditional_fields_controller.default,
  "conditional-fields": _conditional_fields_controller.default,
  "date-picker": _date_picker_controller.default,
  "icon-select": _icon_select_controller.default,
  notice: _notice_controller.default,
  "file-upload": _file_upload_controller.default,
  popper: _popper_controller.default,
  search: _search_controller.default,
  "star-rating": _star_rating_controller.default,
  table: _table_controller.default,
  "visibility-toggle": _visibility_toggle_controller.default
};
var _default = controllers;
exports.default = _default;