# https://stackoverflow.com/a/449322
require "active_support/core_ext/numeric"

class Time
  # Time#round already exists with different meaning in Ruby 1.9
  def round_to(seconds = 60)
    Time.at((to_f / seconds).round * seconds).utc
  end

  def floor(seconds = 60)
    Time.at((to_f / seconds).floor * seconds).utc
  end
end
