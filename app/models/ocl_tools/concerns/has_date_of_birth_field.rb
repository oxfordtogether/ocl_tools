module OclTools
  module Concerns
    module HasDateOfBirthField
      extend ActiveSupport::Concern

      class_methods do
        def has_date_of_birth_field(field_name)
          raise "Date of birth field must end with date_of_birth" unless field_name.to_s.ends_with?("date_of_birth")

          prefix = field_name.to_s.split("date_of_birth").first || ""

          define_method("#{prefix}age") do |on = nil|
            dob = send(field_name)
            on ||= Date.today
            return if dob.nil?

            # have they had their birthday this year?
            if on.month < dob.month || on.month == dob.month && on.day < dob.day
              on.year - dob.year - 1
            else
              on.year - dob.year
            end
          end
        end
      end
    end
  end
end
