module OclTools
  module Address
    module Helpers
      def self.normalize_postcode(str)
        str&.downcase&.gsub(/\s/, '')
      end

      def self.format_postcode(str)
        str&.chars&.insert(-4, ' ')&.join&.upcase
      end
    end
  end
end
