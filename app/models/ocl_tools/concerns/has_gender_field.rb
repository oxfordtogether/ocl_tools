module OclTools
  module Concerns
    module HasGenderField
      extend ActiveSupport::Concern

      class_methods do
        def has_gender_field(field_name)
          better_options_field field_name do
            option :female, "Female"
            option :male, "Male"
            option :other, "Other"
            option :prefer_not_to_say, "Prefer not to say"
            option :none_of_these, "None of these"
          end
        end
      end
    end
  end
end
