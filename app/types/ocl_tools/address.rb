module OclTools
  class Address
    ATTRS = %i[line_1 line_2 line_3 town city postcode] # some apps have town, some have city 🤦‍♂️
    attr_accessor(*ATTRS)

    def initialize(attrs = {})
      attrs.filter { |k, v| ATTRS.include?(k) }.each { |k, v| send("#{k}=", v) }
    end

    def self.from(obj, prefix: :address)
      new(ATTRS.map { |a| [a, obj.try("#{prefix}_#{a}")] }.to_h)
    end
  end
end
