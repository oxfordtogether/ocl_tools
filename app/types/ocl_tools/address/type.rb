module OclTools
  module Address
    class Type
      attr_accessor :line_1, :line_2, :line_3, :city, :normalized_postcode

      def initialize(line_1:, line_2:, line_3:, city:, postcode:)
        @line_1 = line_1
        @line_2 = line_2
        @line_3 = line_3
        @city = city
        @normalized_postcode = Helpers.normalize_postcode(postcode)
      end

      def single_line
        lines.join(', ')
      end

      def to_s
        single_line
      end

      def all_lines
        [line_1, line_2, line_3, city, postcode]
      end

      def lines
        all_lines.filter { |l| l.present? }
      end

      def postcode
        Helpers.format_postcode(normalized_postcode)
      end

      def outcode
        Helpers.format_outcode(normalized_postcode)
      end

      def ==(other)
        return false unless other.is_a?(Type)

        all_lines == other.all_lines
      end

      def empty?
        lines.empty?
      end
    end
  end
end
