require "ocl_tools/spec_helpers/autocomplete_select"
require "ocl_tools/spec_helpers/date_picker_select"
require "ocl_tools/spec_helpers/date_field_fill_in"
require "ocl_tools/spec_helpers/time_select"
require "ocl_tools/spec_helpers/wait_for_turbolinks"

RSpec.configure do |config|
  config.include OclTools::AutocompleteSelect, type: :system
  config.include OclTools::DatePickerSelect, type: :system
  config.include OclTools::WaitForTurbolinks, type: :system
  config.include OclTools::DateFieldFillIn, type: :system
  config.include OclTools::TimeSelect, type: :system
end
