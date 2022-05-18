module OclTools
  module Concerns
    module NormalizeBlankValues
      extend ActiveSupport::Concern

      included do
        before_validation :normalize_blank_values
      end

      def normalize_blank_values
        attributes.each do |column, _value|
          self[column] = nil unless self[column].present? || self[column] == false
        end
      end
    end
  end
end
