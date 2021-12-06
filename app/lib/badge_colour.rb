class BadgeColour 
  COLOURS = {
    yellow: "bg-yellow-100 text-yellow-800",
    pink: "bg-pink-100 text-pink-800",
    blue: "bg-blue-100 text-blue-800",
    green: "bg-green-100 text-green-800",
    grey: "bg-gray-100 text-gray-800",
    red: "bg-red-100 text-red-800",
    indigo: "bg-indigo-100 text-indigo-800",
    purple: "bg-purple-100 text-purple-800",
  }.freeze

  def self.default
    :blue
  end

  def self.colours
    COLOURS.keys
  end

  def self.css(colour_key)
    COLOURS.fetch(colour_key) { raise BadgeColourError.new(colour_key) }
  end

  def self.valid?(colour_key)
    colours.include?(colour_key)
  end

  def self.check(colour_key)
    (valid? && colour_key) || raise(BadgeColourError.new(colour_key))
  end

  class BadgeColourError < ArgumentError
    def initialize(colour)
      @colour = colour
    end

    def message
      "Unrecognised colour: #{@colour.inspect}. Allowed colours: #{BadgeColour.colours.map(&:inspect).join(', ')}"
    end
  end
end
