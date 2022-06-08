module OclTools
  module Name
    class Type
      include Comparable
      ATTRS = %i[title first_name last_name preferred_name].freeze
      attr_accessor(*ATTRS)

      def initialize(attrs = {})
        attrs.filter { |k, _| ATTRS.include?(k) }.each { |k, v| send("#{k}=", v) }
      end

      def self.from(obj, prefix: nil)
        new(ATTRS.map { |a| [a, obj.try(prefix ? "#{prefix}_#{a}" : a)] }.to_h)
      end

      def preferred_full_name
        "#{preferred_name.present? ? preferred_name : first_name} #{last_name}"
      end

      def official_full_name
        "#{first_name} #{last_name}"
      end

      def full_name
        if preferred_name.present?
          "#{first_name} (#{preferred_name}) #{last_name}"
        else
          "#{first_name} #{last_name}"
        end
      end

      def initials
        [preferred_name || first_name, last_name].map(&:first).join
      end

      def has_preferred?
        preferred_name.present?
      end

      def to_s
        preferred_full_name
      end

      def empty?
        ATTRS.all?(&:empty?)
      end

      def ==(other)
        ATTRS.all? { |a| send(a) == other.send(a) }
      end

      def <=>(other)
        to_s <=> other.to_s
      end
    end
  end
end
