import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import StimulusReflex from "stimulus_reflex";
import consumer from "../channels/consumer";

const application = Application.start();
const context = require.context("controllers", true, /_controller\.js$/);
application.load(definitionsFromContext(context));
StimulusReflex.initialize(application, { consumer });

import { default as AutocompleteController } from "./autocomplete_controller";
import { default as ConditionalFieldsController } from "./conditional_fields_controller";
import { default as DatePickerController } from "./date_picker_controller";
import { default as FileUploadController } from "./file_upload_controller";
import { default as NoticeController } from "./notice_controller";
import { default as SearchController } from "./search_controller";
import { default as TableController } from "./table_controller";
import { default as VisibilityToggleController } from "./visibility_toggle_controller";

const controllers = {
  autocomplete: AutocompleteController,
  "conditional-fields": ConditionalFieldsController,
  "date-picker": DatePickerController,
  notice: NoticeController,
  "file-upload": FileUploadController,
  search: SearchController,
  table: TableController,
  "visibility-toggle": VisibilityToggleController,
};

export default controllers;
