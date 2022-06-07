require 'ocl_tools/spec_helpers/autocomplete_select'
require 'ocl_tools/spec_helpers/date_picker_select'
require 'ocl_tools/spec_helpers/date_field_fill_in'
require 'ocl_tools/spec_helpers/time_select'
require 'ocl_tools/spec_helpers/wait_for_turbolinks'
require 'ocl_tools/spec_helpers/fill_in_date'
require 'ocl_tools/spec_helpers/fill_in_rich_text'
require 'ocl_tools/spec_helpers/radio_group_select'
require 'ocl_tools/spec_helpers/fill_in_datetime'

RSpec.configure do |config|
  config.include OclTools::AutocompleteSelect, type: :system
  config.include OclTools::DatePickerSelect, type: :system
  config.include OclTools::WaitForTurbolinks, type: :system
  config.include OclTools::DateFieldFillIn, type: :system
  config.include OclTools::TimeSelect, type: :system
  config.include OclTools::FillInDate, type: :system
  config.include OclTools::FillInRichText, type: :system
  config.include OclTools::RadioGroupSelect, type: :system
  config.include OclTools::FillInDatetime, type: :system
end
