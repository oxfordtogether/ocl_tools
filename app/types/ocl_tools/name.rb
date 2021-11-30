module OclTools
  class Name
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

    def full_name
      if preferred_name.present?
        "#{first_name} (#{preferred_name}) #{last_name}"
      else
        "#{first_name} #{last_name}"
      end
    end
  end
end
