module OclTools
  module Address
    module Helpers
      def self.normalize_postcode(str)
        str&.downcase&.gsub(/\s/, '')
      end

      def self.format_postcode(str)
        return unless str

        if str.length < 5 # not a real postcode
          str
        else
          str&.chars&.insert(-4, ' ')&.join&.upcase
        end
      end

      def self.format_outcode(str)
        # returns outward code i.e. first half of postcode (before space)
        return unless str

        if str.length < 5 # not a real postcode
          str
        else
          str.chars[0..-4].join.upcase
        end
      end
    end
  end
end
