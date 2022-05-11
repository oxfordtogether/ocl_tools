module OclTools
  module Address
    module Helpers
      def self.normalize_postcode(str)
        str&.downcase&.gsub(/\s/, '')
      end

      def self.format_postcode(str)
        return unless str

        if str.length < 6 # not a real postcode
          str
        else
          str&.chars&.insert(-4, ' ')&.join&.upcase
        end
      end
    end
  end
end
