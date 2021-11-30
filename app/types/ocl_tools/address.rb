module OclTools
  class Address
    ATTRS = %i[line_1 line_2 line_3 town postcode]
    attr_accessor(*ATTRS)

    def initialize(attrs = {})
      attrs.filter { |k, v| ATTRS.include?(k) }.each { |k, v| send("#{k}=", v) }
    end

    def self.from(obj, prefix: :address)
      new(ATTRS.map { |a| [a, obj.send("#{prefix}_#{a}")] }.to_h)
    end
  end
end
