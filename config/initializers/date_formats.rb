day_long = ->(date) { date.strftime("%a #{date.day.ordinalize} %b, %Y") }
relative = lambda do |date|
  if date.today? && date.to_date != date
    # we don't want to display 00:00 when it's a date or a time that was converted from a date
    # date.to_date != date is true if and only if the time part is non-zero
    date.strftime("%H:%M")
  elsif date.year == Date.today.year
    date.strftime("#{date.day.ordinalize} %b")
  else
    date.strftime("#{date.day.ordinalize} %b %Y")
  end
end

Time::DATE_FORMATS[:day_long] = Date::DATE_FORMATS[:day_long] = day_long
Time::DATE_FORMATS[:relative] = Date::DATE_FORMATS[:relative] = relative
